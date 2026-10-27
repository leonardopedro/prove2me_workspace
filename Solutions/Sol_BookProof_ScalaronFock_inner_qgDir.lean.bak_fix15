-- Generated from ChapterScalaronFockEsa.lean — solution of BookProof.ScalaronFock.inner_qgDir
import Mathlib
import Definitions.Def_ChapterScalaronFockEsa
open BookProof.ScalaronFock



open Filter Topology MeasureTheory SchwartzMap


open BookProof.FarisLavine BookProof.Starobinsky BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.QuantumGravityDensitized BookProof.ChapterStoneResolvent

noncomputable section

variable {E : ℕ → Type*} [∀ n, NormedAddCommGroup (E n)] [∀ n, InnerProductSpace ℝ (E n)]
  [∀ n, FiniteDimensional ℝ (E n)] [∀ n, MeasurableSpace (E n)] [∀ n, BorelSpace (E n)]

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (x : qgSector n) (j : Fin n) (i : Fin 2) :
    (inner ℝ x (qgDir n j i) : ℝ) = x (j, i) := by

  rw [qgDir, EuclideanSpace.inner_single_right]
  simp
