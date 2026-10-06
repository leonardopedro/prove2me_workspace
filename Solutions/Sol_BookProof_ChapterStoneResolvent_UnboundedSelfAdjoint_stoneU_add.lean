-- Generated from ChapterStoneUnitary.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.stoneU_add
import Mathlib
import Definitions.Def_ChapterStoneUnitary
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_approxU_add
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_approxU_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_tendsto_stoneU
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (s t : ℝ) : T.stoneU (s + t) = T.stoneU s * T.stoneU t := by

  ext x
  refine tendsto_nhds_unique (T.tendsto_stoneU (s + t) x) ?_
  have h : (fun k : ℕ => T.approxU ((k : ℝ) + 1) (s + t) x)
      = fun k : ℕ => T.approxU ((k : ℝ) + 1) s (T.approxU ((k : ℝ) + 1) t x) := by
    funext k
    rw [T.approxU_add]
    rfl
  rw [h]
  -- `E_k(s) (E_k(t) x) → U(s) (U(t) x)`
  have hgoal : Tendsto (fun k : ℕ => T.approxU ((k : ℝ) + 1) s (T.approxU ((k : ℝ) + 1) t x))
      atTop (𝓝 (T.stoneU s (T.stoneU t x))) := by
    rw [Metric.tendsto_atTop]
    intro ε hε
    obtain ⟨N₁, hN₁⟩ := Metric.tendsto_atTop.mp (T.tendsto_stoneU t x) (ε / 2) (by linarith)
    obtain ⟨N₂, hN₂⟩ :=
      Metric.tendsto_atTop.mp (T.tendsto_stoneU s (T.stoneU t x)) (ε / 2) (by linarith)
    refine ⟨max N₁ N₂, fun k hk => ?_⟩
    have hk1 : N₁ ≤ k := le_trans (le_max_left _ _) hk
    have hk2 : N₂ ≤ k := le_trans (le_max_right _ _) hk
    have h1 : dist (T.approxU ((k : ℝ) + 1) s (T.approxU ((k : ℝ) + 1) t x))
        (T.approxU ((k : ℝ) + 1) s (T.stoneU t x)) < ε / 2 := by
      rw [dist_eq_norm, ← map_sub, T.norm_approxU_apply]
      have := hN₁ k hk1
      rwa [dist_eq_norm] at this
    have h2 : dist (T.approxU ((k : ℝ) + 1) s (T.stoneU t x)) (T.stoneU s (T.stoneU t x)) < ε / 2 :=
      hN₂ k hk2
    calc dist (T.approxU ((k : ℝ) + 1) s (T.approxU ((k : ℝ) + 1) t x))
          (T.stoneU s (T.stoneU t x))
        ≤ dist (T.approxU ((k : ℝ) + 1) s (T.approxU ((k : ℝ) + 1) t x))
            (T.approxU ((k : ℝ) + 1) s (T.stoneU t x))
          + dist (T.approxU ((k : ℝ) + 1) s (T.stoneU t x)) (T.stoneU s (T.stoneU t x)) :=
          dist_triangle _ _ _
      _ < ε := by linarith
  exact hgoal
