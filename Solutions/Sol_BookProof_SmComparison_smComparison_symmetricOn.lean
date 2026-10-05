-- Generated from ChapterSmComparison.lean — solution of BookProof.SmComparison.smComparison_symmetricOn
import Mathlib
import Definitions.Def_ChapterSmComparison
import Theorems.Thm_BookProof_SmComparison_smConfField_symmetricOn
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_symmetricOn
open BookProof.SmComparison




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.ScalaronWallEsa BookProof.ScalaronEsa BookProof.WallEsaBddBelow
open BookProof.TensorSumChain BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.EsaClosure BookProof.GraphCore
open BookProof.StoneBridge BookProof.ChapterStoneResolvent
open MeasureTheory

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (c0 : ℝ) :
    SymmetricOn (polyGaussCore (d := 163)) (smComparison c0) := by

  intro x y
  have hw := weylOpDom_symmetricOn smPi_symmetricOn smConfField_symmetricOn x y
  simp only [smComparison, LinearMap.add_apply, LinearMap.smul_apply, Submodule.subtype_apply,
    inner_add_left, inner_add_right, inner_smul_left, inner_smul_right, Complex.conj_ofReal,
    map_ofNat]
  rw [hw]
