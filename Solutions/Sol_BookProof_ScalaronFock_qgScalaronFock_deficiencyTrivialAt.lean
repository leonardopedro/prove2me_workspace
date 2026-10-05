-- Generated from ChapterScalaronFockEsa.lean — solution of BookProof.ScalaronFock.qgScalaronFock_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterScalaronFockEsa
import Theorems.Thm_BookProof_ScalaronFock_fockSmoothPotential_deficiencyTrivialAt
open BookProof.ScalaronFock



open Filter Topology MeasureTheory SchwartzMap


open BookProof.FarisLavine BookProof.Starobinsky BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.QuantumGravityDensitized BookProof.ChapterStoneResolvent

noncomputable section

variable {E : ℕ → Type*} [∀ n, NormedAddCommGroup (E n)] [∀ n, InnerProductSpace ℝ (E n)]
  [∀ n, FiniteDimensional ℝ (E n)] [∀ n, MeasurableSpace (E n)] [∀ n, BorelSpace (E n)]

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt qgFockCore (qgScalaronFockHamiltonian M alpha) z := fockSmoothPotential_deficiencyTrivialAt _ _ hz
