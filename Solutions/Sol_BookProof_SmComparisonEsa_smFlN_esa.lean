-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.smFlN_esa
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Theorems.Thm_BookProof_SmComparisonEsa_smFlN_esa_one_le
import Theorems.Thm_BookProof_KatoRellich_essentiallySelfAdjointOn_add_bounded
open BookProof.SmComparisonEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (c0 : ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 163)) (smFlN P c0) := by

  have hbase := smFlN_esa_one_le P (c0 := 1) le_rfl
  have hsym := smFlN_symmetricOn P 1
  have hkey := BookProof.KatoRellich.essentiallySelfAdjointOn_add_bounded (smFlN P 1) hsym hbase
    (((c0 - 1 : ℝ) : ℂ) • ContinuousLinearMap.id ℂ (L2d 163)) (fun u v => by
      simp only [ContinuousLinearMap.smul_apply, ContinuousLinearMap.id_apply,
        inner_smul_left, inner_smul_right, Complex.conj_ofReal])
  have hid : smFlN P 1
      + ((((c0 - 1 : ℝ) : ℂ) • ContinuousLinearMap.id ℂ (L2d 163)).toLinearMap
        ∘ₗ (polyGaussCore (d := 163)).subtype) = smFlN P c0 := by
    refine LinearMap.ext fun x => ?_
    simp only [LinearMap.add_apply, LinearMap.coe_comp, Function.comp_apply,
      Submodule.subtype_apply, ContinuousLinearMap.coe_coe, ContinuousLinearMap.smul_apply,
      ContinuousLinearMap.id_apply, smFlN_apply]
    push_cast
    module
  rwa [hid] at hkey
