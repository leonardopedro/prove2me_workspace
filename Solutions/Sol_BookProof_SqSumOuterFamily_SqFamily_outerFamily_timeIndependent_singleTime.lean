-- Generated from ChapterSqSumOuterSingleTime.lean — solution of BookProof.SqSumOuterFamily.SqFamily.outerFamily_timeIndependent_singleTime
import Mathlib
import Definitions.Def_ChapterSqSumOuterSingleTime
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_truncHam_symmetricOn
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_truncHam_esa
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_truncHam_tendsto
import Theorems.Thm_BookProof_QgTimeIndependent_eq_prop_of_isSchrodingerSolution
import Theorems.Thm_BookProof_QgTimeIndependent_norm_prop_apply
import Theorems.Thm_BookProof_QgTimeIndependent_prop_apply_prop
import Theorems.Thm_BookProof_QgTimeIndependent_prop_time_translation
import Theorems.Thm_BookProof_QgTruncationResolvent_strongResolventConvergence_of_core
import Theorems.Thm_BookProof_SirkSingleTime_isShiftInvertC_neg_resCLM_shift
import Theorems.Thm_BookProof_SirkSingleTime_singleTime_flow_tendsto_of_strongResAt
import Theorems.Thm_BookProof_SirkSingleTime_strongResAt_of_ne_zero
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_outerHam_esa
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_outerHam_symmetricOn
import Theorems.Thm_BookProof_SqSumOuterFamily_outerCore_dense
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
open BookProof.SqSumOuterFamily




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.QgTimeIndependent BookProof.QgTruncationResolvent
open BookProof.DirectSumEsa BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (F : SqFamily) :
    ∃ (T : UnboundedSelfAdjoint (outerFock F.dim))
      (S : ℕ → UnboundedSelfAdjoint (outerFock F.dim)),
      IsSelfAdjointExtension F.outerHam T.op ∧
        (∀ N, IsSelfAdjointExtension (truncHam F N) (S N).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : outerFock F.dim), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : outerFock F.dim), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → outerFock F.dim, IsSchrodingerSolution T y →
          ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ N, IsShiftInvertC (S N).op (((l : ℝ) : ℂ) * Complex.I) (-((S N).resCLM l))) ∧
            ∀ u : outerFock F.dim,
              Tendsto (fun N => -((S N).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : outerFock F.dim) (t : ℝ),
          Tendsto (fun N => (S N).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by

  obtain ⟨T, _U, hT, _hflow⟩ :=
    exists_stone_flow_of_esa F.outerHam (outerCore_dense F.dim) F.outerHam_symmetricOn
      F.outerHam_esa
  have hex : ∀ N : ℕ, ∃ S : UnboundedSelfAdjoint (outerFock F.dim),
      IsSelfAdjointExtension (truncHam F N) S.op := by
    intro N
    obtain ⟨S, _, hS, _⟩ :=
      exists_stone_flow_of_esa (truncHam F N) (outerCore_dense F.dim)
        (truncHam_symmetricOn F N) (truncHam_esa F N)
    exact ⟨S, hS⟩
  choose S hS using hex
  have hsrc : StrongResolventConvergence T S :=
    strongResolventConvergence_of_core (Hn := fun N => truncHam F N)
      F.outerHam_esa hT hS (fun x => F.truncHam_tendsto x)
  have hres1 : StrongResAt T S 1 := fun y => hsrc y
  exact ⟨T, S, hT, hS, fun t s => rfl, fun t s x => norm_prop_apply T t s x,
    fun t s r x => prop_apply_prop T t s r x, fun t s h => prop_time_translation T t s h,
    fun _ hy t s => eq_prop_of_isSchrodingerSolution T hy t s,
    fun l hl => ⟨isShiftInvertC_neg_resCLM_shift T hl,
      fun N => isShiftInvertC_neg_resCLM_shift (S N) hl,
      fun u => (strongResAt_of_ne_zero one_ne_zero hl hres1 u).neg⟩,
    fun v t => singleTime_flow_tendsto_of_strongResAt one_ne_zero hres1 v t⟩
