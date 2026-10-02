-- Generated from ChapterFiniteSectionSingleTime.lean — solution of BookProof.FiniteSectionSingleTime.finiteSection_singleTime
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
import Theorems.Thm_BookProof_FiniteSectionSingleTime_secOp_isSelfAdjoint
import Theorems.Thm_BookProof_FiniteSectionSingleTime_secOp_tendsto_core
import Theorems.Thm_BookProof_FiniteSectionSingleTime_isSelfAdjointExtension_ofBounded
import Theorems.Thm_BookProof_QgTimeIndependent_eq_prop_of_isSchrodingerSolution
import Theorems.Thm_BookProof_QgTimeIndependent_norm_prop_apply
import Theorems.Thm_BookProof_QgTimeIndependent_prop_apply_prop
import Theorems.Thm_BookProof_QgTimeIndependent_prop_time_translation
import Theorems.Thm_BookProof_QgTruncationResolvent_strongResolventConvergence_of_core
import Theorems.Thm_BookProof_SirkSingleTime_isShiftInvertC_neg_resCLM_shift
import Theorems.Thm_BookProof_SirkSingleTime_singleTime_flow_tendsto_of_strongResAt
import Theorems.Thm_BookProof_SirkSingleTime_strongResAt_of_ne_zero
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa



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
theorem solution (hsym : SymmetricOn (lpFiniteModes ι) H)
    (hesa : EssentiallySelfAdjointOn (lpFiniteModes ι) H)
    {W : ℕ → Finset ι} (hW : Exhausts W) :
    ∃ (T : UnboundedSelfAdjoint (L2I ι)) (S : ℕ → UnboundedSelfAdjoint (L2I ι)),
      IsSelfAdjointExtension H T.op ∧
        (∀ n, IsSelfAdjointExtension
          (((secOp H (W n) : L2I ι →ₗ[ℂ] L2I ι)).comp (lpFiniteModes ι).subtype) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : L2I ι), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : L2I ι), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → L2I ι, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : L2I ι,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : L2I ι) (t : ℝ), Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by

  obtain ⟨T, _U, hT, _hflow⟩ :=
    exists_stone_flow_of_esa H lpFiniteModes_dense hsym hesa
  set S : ℕ → UnboundedSelfAdjoint (L2I ι) :=
    fun n => ofBounded (secOp H (W n)) (secOp_isSelfAdjoint H hsym) with hSdef
  have hS : ∀ n, IsSelfAdjointExtension
      (((secOp H (W n) : L2I ι →ₗ[ℂ] L2I ι)).comp (lpFiniteModes ι).subtype) (S n).op :=
    fun n => isSelfAdjointExtension_ofBounded _ _ _
  have hconv : ∀ x : lpFiniteModes ι,
      Tendsto (fun n => ((secOp H (W n) : L2I ι →ₗ[ℂ] L2I ι)).comp
        (lpFiniteModes ι).subtype x) atTop (𝓝 (H x)) := by
    intro x
    exact secOp_tendsto_core H hW x
  have hsrc : StrongResolventConvergence T S :=
    strongResolventConvergence_of_core hesa hT hS hconv
  have hres1 : StrongResAt T S 1 := fun y => hsrc y
  refine ⟨T, S, hT, hS, fun t s => rfl, fun t s x => norm_prop_apply T t s x,
    fun t s r x => prop_apply_prop T t s r x, fun t s h => prop_time_translation T t s h,
    fun _ hy t s => eq_prop_of_isSchrodingerSolution T hy t s,
    fun l hl => ⟨isShiftInvertC_neg_resCLM_shift T hl,
      fun n => isShiftInvertC_neg_resCLM_shift (S n) hl,
      fun u => (strongResAt_of_ne_zero one_ne_zero hl hres1 u).neg⟩,
    fun v t => singleTime_flow_tendsto_of_strongResAt one_ne_zero hres1 v t⟩
