-- Generated from ChapterFiniteSectionSingleTime.lean — solution of BookProof.FiniteSectionSingleTime.secOp_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
import Theorems.Thm_BookProof_FiniteSectionSingleTime_coreVec_coe
import Theorems.Thm_BookProof_FiniteSectionSingleTime_inner_basisVec
import Theorems.Thm_BookProof_FiniteSectionSingleTime_inner_basisVec'
import Theorems.Thm_BookProof_FiniteSectionSingleTime_projW_apply
import Theorems.Thm_BookProof_FiniteSectionSingleTime_secOp_apply



open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {ι : Type*} [DecidableEq ι]

variable {ι : Type*} [DecidableEq ι]
variable (H : lpFiniteModes ι →ₗ[ℂ] L2I ι)

set_option maxHeartbeats 1000000 in
theorem solution {W : Finset ι} (hsym : SymmetricOn (lpFiniteModes ι) H) :
    IsSelfAdjoint (secOp H W) := by

  rw [ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric]
  intro x y
  simp only [ContinuousLinearMap.coe_coe]
  have hherm : ∀ a c : ι, (starRingEnd ℂ) (((H (coreVec a) : L2I ι) : ι → ℂ) c)
      = ((H (coreVec c) : L2I ι) : ι → ℂ) a := by
    intro a c
    have h := hsym (coreVec c) (coreVec a)
    have h1 : (inner ℂ (H (coreVec c)) (basisVec a) : ℂ)
        = (starRingEnd ℂ) (((H (coreVec c) : L2I ι) : ι → ℂ) a) := by
      rw [← inner_conj_symm, inner_basisVec]
    have h2 : (inner ℂ (basisVec c) (H (coreVec a)) : ℂ)
        = ((H (coreVec a) : L2I ι) : ι → ℂ) c := inner_basisVec _ _
    rw [coreVec_coe, coreVec_coe, h1, h2] at h
    rw [← h]
    simp
  have hexp : (inner ℂ (secOp H W x) y : ℂ)
      = ∑ a ∈ W, ∑ c ∈ W, (starRingEnd ℂ) ((x : ι → ℂ) a)
          * (starRingEnd ℂ) (((H (coreVec a) : L2I ι) : ι → ℂ) c) * ((y : ι → ℂ) c) := by
    rw [secOp_apply, sum_inner]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [inner_smul_left, projW_apply, sum_inner, Finset.mul_sum]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [inner_smul_left, inner_basisVec]
    ring
  have hexp2 : (inner ℂ x (secOp H W y) : ℂ)
      = ∑ a ∈ W, ∑ c ∈ W, (starRingEnd ℂ) ((x : ι → ℂ) c)
          * (((H (coreVec a) : L2I ι) : ι → ℂ) c) * ((y : ι → ℂ) a) := by
    rw [secOp_apply, inner_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [inner_smul_right, projW_apply, inner_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [inner_smul_right, inner_basisVec']
    ring
  have hcomm : ∑ a ∈ W, ∑ c ∈ W, (starRingEnd ℂ) ((x : ι → ℂ) c)
        * (((H (coreVec a) : L2I ι) : ι → ℂ) c) * ((y : ι → ℂ) a)
      = ∑ a ∈ W, ∑ c ∈ W, (starRingEnd ℂ) ((x : ι → ℂ) a)
        * (((H (coreVec c) : L2I ι) : ι → ℂ) a) * ((y : ι → ℂ) c) := Finset.sum_comm
  rw [hexp, hexp2, hcomm]
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun c _ => ?_
  rw [hherm a c]
