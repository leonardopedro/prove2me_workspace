-- Generated from ChapterScalaronFockEsa.lean — solution of BookProof.ScalaronFock.qgManyPotential_ge
import Mathlib
import Definitions.Def_ChapterScalaronFockEsa
import Theorems.Thm_BookProof_ScalaronEsa_scalaronFullPotential_ge
open BookProof.ScalaronFock



open Filter Topology MeasureTheory SchwartzMap


open BookProof.FarisLavine BookProof.Starobinsky BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.QuantumGravityDensitized BookProof.ChapterStoneResolvent

noncomputable section

variable {E : ℕ → Type*} [∀ n, NormedAddCommGroup (E n)] [∀ n, InnerProductSpace ℝ (E n)]
  [∀ n, FiniteDimensional ℝ (E n)] [∀ n, MeasurableSpace (E n)] [∀ n, BorelSpace (E n)]

set_option maxHeartbeats 1000000 in
theorem solution {M alpha : ℝ} (halpha : 0 < alpha) (n : ℕ) (x : qgSector n) :
    -(n * (M ^ 4 / (16 * alpha))) ≤ qgManyPotential M alpha n x := by

  have hterm : ∀ j : Fin n,
      -(M ^ 4 / (16 * alpha)) ≤ scalaronFullPotential M alpha (qgDir n j 0) (qgDir n j 1) x :=
    fun j => scalaronFullPotential_ge halpha _ _ x
  have hsum := Finset.sum_le_sum (fun j (_ : j ∈ Finset.univ) => hterm j)
  simpa [qgManyPotential, Finset.sum_const, nsmul_eq_mul, mul_comm] using hsum
