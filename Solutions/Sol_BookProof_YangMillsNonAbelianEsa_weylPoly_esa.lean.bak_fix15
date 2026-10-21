-- Generated from ChapterYangMillsNonAbelianEsa.lean — solution of BookProof.YangMillsNonAbelianEsa.weylPoly_esa
import Mathlib
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_essentiallySelfAdjointOn_affine
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_realCoeff_weylPotPoly
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_one_le_polyW_weylPotPoly
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_weylPoly_eq_hamCoreS
import Theorems.Thm_BookProof_DegSchrodinger_continuous_polyW
import Theorems.Thm_BookProof_DegSchrodinger_expBounded_polyW
import Theorems.Thm_BookProof_DegSchrodinger_hamCoreS_symmetricOn
import Theorems.Thm_BookProof_HermiteGraphApprox_hamCoreS_esa
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
theorem solution {idx : Fin k → Fin d} (hidx : Function.Injective idx)
    {Φ : Fin r → MvPolynomial (Fin d) ℂ} (hΦ : ∀ j, RealCoeff (Φ j)) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (weylPoly idx Φ) := by

  rw [weylPoly_eq_hamCoreS hidx hΦ]
  exact essentiallySelfAdjointOn_affine _ (hamCoreS_symmetricOn _ _ _ _)
    (hamCoreS_esa (weylPotPoly Φ) (realCoeff_weylPotPoly hΦ) (one_le_polyW_weylPotPoly hΦ) _)
    (by norm_num) _
