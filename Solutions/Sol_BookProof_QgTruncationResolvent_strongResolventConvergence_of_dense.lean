-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.strongResolventConvergence_of_dense
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_resCLM_apply_le




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {T : UnboundedSelfAdjoint F}
    {S : ℕ → UnboundedSelfAdjoint F} {G : Set F} (hG : Dense G)
    (h : ∀ y ∈ G, Tendsto (fun n => (S n).resCLM 1 y) atTop (𝓝 (T.resCLM 1 y))) :
    StrongResolventConvergence T S := by

  intro y
  rw [Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨y', hy'G, hy'⟩ := Metric.mem_closure_iff.mp (hG y) (ε / 3) (by linarith)
  have hbound : ∀ (R : UnboundedSelfAdjoint F) (z : F), ‖R.resCLM 1 z‖ ≤ ‖z‖ := by
    intro R z
    have := R.norm_resCLM_apply_le 1 z
    simpa using this
  have hyy : ‖y - y'‖ < ε / 3 := by rwa [← dist_eq_norm]
  obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp (h y' hy'G) (ε / 3) (by linarith)
  refine ⟨N, fun n hn => ?_⟩
  have hsplit : (S n).resCLM 1 y - T.resCLM 1 y
      = (S n).resCLM 1 (y - y') + ((S n).resCLM 1 y' - T.resCLM 1 y')
        - T.resCLM 1 (y - y') := by
    rw [map_sub, map_sub]; abel
  have h1 : ‖(S n).resCLM 1 (y - y')‖ ≤ ‖y - y'‖ := hbound _ _
  have h2 : ‖T.resCLM 1 (y - y')‖ ≤ ‖y - y'‖ := hbound _ _
  have h3 : ‖(S n).resCLM 1 y' - T.resCLM 1 y'‖ < ε / 3 := by
    have := hN n hn
    rwa [dist_eq_norm] at this
  have : ‖(S n).resCLM 1 y - T.resCLM 1 y‖ < ε := by
    rw [hsplit]
    calc ‖(S n).resCLM 1 (y - y') + ((S n).resCLM 1 y' - T.resCLM 1 y') - T.resCLM 1 (y - y')‖
        ≤ ‖(S n).resCLM 1 (y - y') + ((S n).resCLM 1 y' - T.resCLM 1 y')‖
            + ‖T.resCLM 1 (y - y')‖ := norm_sub_le _ _
      _ ≤ ‖(S n).resCLM 1 (y - y')‖ + ‖(S n).resCLM 1 y' - T.resCLM 1 y'‖
            + ‖T.resCLM 1 (y - y')‖ := by
            have := norm_add_le ((S n).resCLM 1 (y - y'))
              ((S n).resCLM 1 y' - T.resCLM 1 y')
            linarith
      _ < ε := by linarith
  rwa [dist_eq_norm]
