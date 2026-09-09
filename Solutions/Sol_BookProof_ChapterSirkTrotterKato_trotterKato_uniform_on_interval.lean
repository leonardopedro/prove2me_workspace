-- Generated from ChapterSirkTrotterKato.lean — solution of BookProof.ChapterSirkTrotterKato.trotterKato_uniform_on_interval
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_trotterKato_uniform_of_mem_range
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_exists_res_domain_approx
open BookProof.ChapterSirkTrotterKato











noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]













variable (T : UnboundedSelfAdjoint H) (S : ℕ → UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (hres : StrongResolventConvergence T S) (v : H)
    {T₀ : ℝ} (hT₀ : 0 ≤ T₀) {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop, ∀ t : ℝ, |t| ≤ T₀ → ‖(S n).stoneU t v - T.stoneU t v‖ ≤ ε := by

  obtain ⟨w, hw⟩ := exists_res_domain_approx T v (by positivity : (0:ℝ) < ε / 3)
  have hcore := trotterKato_uniform_of_mem_range T S hres w hT₀
    (by positivity : (0:ℝ) < ε / 3)
  filter_upwards [hcore] with n hn t ht
  have h1 : ‖(S n).stoneU t v - (S n).stoneU t (T.resCLM 1 (w : H))‖ ≤ ε / 3 := by
    rw [← map_sub, (S n).norm_stoneU_apply]
    exact le_of_lt hw
  have h3 : ‖T.stoneU t (T.resCLM 1 (w : H)) - T.stoneU t v‖ ≤ ε / 3 := by
    rw [← map_sub, T.norm_stoneU_apply, norm_sub_rev]
    exact le_of_lt hw
  have h2 := hn t ht
  have hsplit : (S n).stoneU t v - T.stoneU t v
      = ((S n).stoneU t v - (S n).stoneU t (T.resCLM 1 (w : H)))
        + ((S n).stoneU t (T.resCLM 1 (w : H)) - T.stoneU t (T.resCLM 1 (w : H)))
        + (T.stoneU t (T.resCLM 1 (w : H)) - T.stoneU t v) := by abel
  calc ‖(S n).stoneU t v - T.stoneU t v‖
      ≤ ‖((S n).stoneU t v - (S n).stoneU t (T.resCLM 1 (w : H)))
          + ((S n).stoneU t (T.resCLM 1 (w : H)) - T.stoneU t (T.resCLM 1 (w : H)))‖
        + ‖T.stoneU t (T.resCLM 1 (w : H)) - T.stoneU t v‖ := by
        rw [hsplit]; exact norm_add_le _ _
    _ ≤ ‖(S n).stoneU t v - (S n).stoneU t (T.resCLM 1 (w : H))‖
        + ‖(S n).stoneU t (T.resCLM 1 (w : H)) - T.stoneU t (T.resCLM 1 (w : H))‖
        + ‖T.stoneU t (T.resCLM 1 (w : H)) - T.stoneU t v‖ := by
        gcongr
        exact norm_add_le _ _
    _ ≤ ε / 3 + ε / 3 + ε / 3 := by gcongr
    _ = ε := by ring
