-- Generated from ChapterYangMillsNonAbelianEsa.lean — solution of BookProof.YangMillsNonAbelianEsa.ym_h_esa
import Mathlib
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_weylPoly_esa
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_ymIdx_injective
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_ymHamiltonian_eq_weylPoly
import Theorems.Thm_BookProof_YangMillsHermite_realCoeff_magPoly
open BookProof.YangMillsNonAbelianEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {d : ℕ}
variable {d k r : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 99)) (ymHamiltonian (coreRepPoly 99) fabc) := by

  rw [ymHamiltonian_eq_weylPoly]
  exact weylPoly_esa ymIdx_injective fun m => realCoeff_magPoly fabc _ _
