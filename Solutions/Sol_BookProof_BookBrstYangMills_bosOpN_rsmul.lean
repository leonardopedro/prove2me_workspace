-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.bosOpN_rsmul
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Theorems.Thm_BookProof_BookBrstYangMills_bosOpN_smul
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (r : ℝ) (T : Module.End ℂ (FieldPoly N)) :
    bosOpN (r • T) = r • bosOpN T := by

  have h1 : (r : ℝ) • T = ((r : ℂ)) • T := by
    ext p
    simp [Complex.real_smul]
  have h2 : ((r : ℂ)) • bosOpN T = (r : ℝ) • bosOpN T := by
    ext x
    first
      | exact algebraMap_smul ℂ r (bosOpN T _)
      | exact (algebraMap_smul ℂ r (bosOpN T _)).symm
      | rfl
  rw [h1, bosOpN_smul, h2]
