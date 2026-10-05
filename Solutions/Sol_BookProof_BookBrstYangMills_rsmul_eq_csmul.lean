-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.rsmul_eq_csmul
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (r : ℝ) (T : Module.End ℂ (BookState N)) :
    r • T = ((r : ℝ) : ℂ) • T := by

  refine LinearMap.ext fun x => ?_
  simp only [LinearMap.smul_apply]
  exact (algebraMap_smul ℂ r (T x)).symm
