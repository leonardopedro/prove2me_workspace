-- Generated from ChapterYangMillsNonAbelianEsa.lean — solution of BookProof.YangMillsNonAbelianEsa.deficiencyTrivialAt_of_esa
import Mathlib
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Theorems.Thm_BookProof_FarisLavine_deficiencyTrivialAt_of_dense_range
import Theorems.Thm_BookProof_FarisLavine_dense_range_of_deficiencyTrivialAt
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

set_option maxHeartbeats 1000000 in
theorem solution (K : D →ₗ[ℂ] F) (hK : SymmetricOn D K)
    (hesa : EssentiallySelfAdjointOn D K) {σ : ℂ} (hσ : σ.im ≠ 0) :
    DeficiencyTrivialAt D K σ := by

  have hI : ((1 : ℝ) : ℂ) * Complex.I = Complex.I := by simp
  have hdense : Dense (Set.range fun x : D => K x - (((1 : ℝ) : ℂ) * Complex.I) • (x : F)) := by
    rw [hI]
    refine dense_range_of_deficiencyTrivialAt K Complex.I ?_
    rw [Complex.conj_I]
    exact hesa.2
  refine deficiencyTrivialAt_of_dense_range K hK 1 one_ne_zero σ hσ hdense ?_
  rw [hI]
  exact hesa.1
