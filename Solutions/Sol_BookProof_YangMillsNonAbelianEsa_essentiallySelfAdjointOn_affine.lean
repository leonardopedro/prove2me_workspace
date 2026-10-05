-- Generated from ChapterYangMillsNonAbelianEsa.lean — solution of BookProof.YangMillsNonAbelianEsa.essentiallySelfAdjointOn_affine
import Mathlib
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_deficiencyTrivialAt_of_esa
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
    (hesa : EssentiallySelfAdjointOn D K) {a : ℝ} (ha : 0 < a) (b : ℝ) :
    EssentiallySelfAdjointOn D ((a : ℂ) • K + (b : ℂ) • D.subtype) := by

  have key : ∀ z : ℂ, z.im ≠ 0 → DeficiencyTrivialAt D ((a : ℂ) • K + (b : ℂ) • D.subtype) z := by
    intro z hz w hw
    have hσ : ((z - b) / a).im ≠ 0 := by
      rw [Complex.div_ofReal_im, Complex.sub_im, Complex.ofReal_im, sub_zero]
      exact div_ne_zero hz ha.ne'
    refine deficiencyTrivialAt_of_esa K hK hesa hσ w fun v => ?_
    have hv := hw v
    rw [LinearMap.add_apply, LinearMap.smul_apply, LinearMap.smul_apply, inner_add_left,
      inner_smul_left, inner_smul_left, Complex.conj_ofReal, Complex.conj_ofReal,
      Submodule.subtype_apply] at hv
    have ha' : (a : ℂ) ≠ 0 := Complex.ofReal_ne_zero.2 ha.ne'
    field_simp
    linear_combination hv
  exact ⟨key _ (by simp), key _ (by simp)⟩
