using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace tsp
{
	public class Solver
	{
		private static int n = 0;
		private static float[,] c = null;
		private static float[,] e = null;
		private static List<int>[] ps = null;

		public static void Main(string[] args)
		{
			if (args == null || args.Length != 1)
			{
				Console.WriteLine("Usage: tsp <FILENAME>");
				return;
			}
			readCities(args[0]);
			calculateEdges();
			powersets(n);
			tsp();
		}

		private static void readCities(string filename)
		{
			using (StreamReader sr = File.OpenText(filename))
			{
				n = int.Parse(sr.ReadLine().Trim());
				c = new float[n,n];
				e = new float[n,n];

				int i = 0;
				while (!sr.EndOfStream)
				{
					string line = sr.ReadLine().Trim();
					float[] coords = line.Split(new []{' '}, 2).Select(t => float.Parse(t)).ToArray();
					c[i,0] = coords[0];
					c[i,1] = coords[1];
					i++;
				}
			}
			Console.WriteLine("Read {0} cities.", n);
		}

		private static void calculateEdges()
		{
			for (int i = 0; i < e.GetLength(0); i++)
			{
				for (int j = i + 1; j < e.GetLength(1); j++)
				{
					float euclid = (float)Math.Sqrt(Math.Pow(c[i,0] - c[j,0], 2) + Math.Pow(c[i,1] - c[j,1], 2));
					e[i, j] = euclid;
					e[j, i] = euclid;
				}
			}
			Console.WriteLine("Calculated {0}x{0} edges.", n);
		}

		private static void tsp()
		{
			int rows = (int) Math.Pow(2, n);
//			long capacity = sizeof (double);
//			Console.WriteLine("Capacity: " + capacity);
//
//			var data = MemoryMappedFile.CreateNew("bigdata", rows * n * sizeof(double));
//			var view = data.CreateViewAccessor();
//
//			double initValue = 0;
//			double maxDouble = double.MaxValue;
//
//			for (int i = 0; i < rows; i++)
//			{
//				for (int j = 0; j < n; j++)
//				{
//					view.Write<double>(i * rows + j, ref maxDouble);
//				}
//			}
//			view.Write<double>(0 * rows + 0, ref initValue);

			float[][] a = new float[rows][];
			
			float[] copy = new float[n];
			for (int j = 0; j < n; j++)
			{
				copy[j] = int.MaxValue;
			}
			
			Console.WriteLine("Created A.");

			for (int i = 0; i < rows; i++)
			{
				a[i] = new float[n];
				Array.Copy(copy, a[i], n);
			}
			a[1][0] = 0;

			Console.WriteLine("Initialized A: {0}x{1}.", a.Length, a[0].Length);

			for (int m = 2; m <= n; m++)
			{
				Console.WriteLine("Problem size: {0}", m);
				foreach (int s in ps[m])
				{
					int[] set = toSet(s);
					foreach (int j in set)
					{
						if (j != 0)
						{
							int s_no_j = unsetBit(s, j);
							float min_a = int.MaxValue;
							foreach (int k in set)
							{
								if (k != j)
								{
									float new_a = a[s_no_j][k] + e[k, j];
									if (min_a > new_a)
									{
										min_a = new_a;
									}
								}
							}
							a[s][j] = min_a;
						}
					}
				}
			}
			Console.WriteLine("Calculated A.");
			float min_path = int.MaxValue;
			for (int j = 1; j < n; j++)
			{
				float new_path = a[a.Length - 1][j] + e[j, 0];
				if (min_path > new_path)
				{
					min_path = new_path;
				}
			}
			Console.WriteLine("Result is {0}.", min_path);
		}

		private static void powersets(int n)
		{
			ps = new List<int>[n + 1];
			for (int i = 0; i < ps.Length; i++)
			{
				ps[i] = new List<int>();
			}

			for (int i = 0; i < Math.Pow(2, n-1); i++)
			{
				int x = (i << 1) | 1;
				int bits = Convert.ToString(x, 2).Count(t => t == '1');
				ps[bits].Add(x);
			}
			Console.WriteLine("Calculated powersets of {0}: {1}.", n, ps.Length);
		}

		private static int unsetBit(int i, int b)
		{
			return ((i & ~(1 << b)) | (0 << b));
		}

		private static int[] toSet(int i)
		{
			List<int> t = new List<int>();
			int bits = Convert.ToString(i, 2).Length;
			for (int b = 0; b < bits; b++)
			{
				if (((i >> b) & 1) == 1)
				{
					t.Add(b);
				}
			}
			return t.ToArray();
		}
	}
}
