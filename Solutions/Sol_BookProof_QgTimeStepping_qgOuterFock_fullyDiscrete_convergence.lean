-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.qgOuterFock_fullyDiscrete_convergence
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_QgTimeStepping_tendsto_iterate_cnStep
import Theorems.Thm_BookProof_QgTruncationResolvent_qgOuterFock_truncation_flow_convergence
open BookProof.QgTimeStepping




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (Q : QgModeData ι) (Λ : ℕ → Set ι)
    (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (S : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam W Q) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam W (truncModes Q (Λ n))) (S n).op) ∧
        ∀ (v : Sec ι) (t : ℝ), 0 < t →
          ∃ k : ℕ → ℕ, (∀ n, 0 < k n) ∧
            Tendsto (fun n => (cnStep (S n) (t / (k n)))^[k n] v) atTop
              (𝓝 (T.stoneU t v)) := by

  obtain ⟨T, S, hT, hS, -, hflow⟩ := qgOuterFock_truncation_flow_convergence W Q Λ hexh
  refine ⟨T, S, hT, hS, fun v t ht => ?_⟩
  have hSn : ∀ n : ℕ, ∃ m : ℕ, ‖(cnStep (S n) (t / ((m : ℝ) + 1)))^[m + 1] v
      - (S n).stoneU t v‖ < 1 / ((n : ℝ) + 1) := by
    intro n
    have h := tendsto_iterate_cnStep (S n) ht v
    rw [Metric.tendsto_atTop] at h
    obtain ⟨N, hN⟩ := h (1 / ((n : ℝ) + 1)) (by positivity)
    exact ⟨N, by simpa [dist_eq_norm] using hN N le_rfl⟩
  choose m hm using hSn
  refine ⟨fun n => m n + 1, fun n => Nat.succ_pos _, ?_⟩
  have hcast : ∀ n : ℕ, (t / ((m n + 1 : ℕ) : ℝ)) = t / ((m n : ℝ) + 1) := by
    intro n; push_cast; ring_nf
  rw [Metric.tendsto_atTop]
  intro eps heps
  have hexact : Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
    (hflow v t (le_of_lt ht)).2 t
  rw [Metric.tendsto_atTop] at hexact
  obtain ⟨N1, hN1⟩ := hexact (eps / 2) (by linarith)
  obtain ⟨N2, hN2⟩ := exists_nat_gt (2 / eps)
  refine ⟨max N1 N2, fun n hn => ?_⟩
  have hn1 : N1 ≤ n := le_trans (le_max_left _ _) hn
  have hn2 : N2 ≤ n := le_trans (le_max_right _ _) hn
  have hA : ‖(cnStep (S n) (t / ((m n + 1 : ℕ) : ℝ)))^[m n + 1] v - (S n).stoneU t v‖
      < 1 / ((n : ℝ) + 1) := by
    rw [hcast n]; exact hm n
  have hB : ‖(S n).stoneU t v - T.stoneU t v‖ < eps / 2 := by
    have := hN1 n hn1
    rwa [dist_eq_norm] at this
  have hC : 1 / ((n : ℝ) + 1) < eps / 2 := by
    have hNn : (N2 : ℝ) ≤ (n : ℝ) := Nat.cast_le.mpr hn2
    have h1 : 2 / eps < (n : ℝ) + 1 := by linarith
    rw [div_lt_iff₀ (by positivity : (0:ℝ) < (n : ℝ) + 1)]
    rw [div_lt_iff₀ heps] at h1
    linarith
  have hsplit : (cnStep (S n) (t / ((m n + 1 : ℕ) : ℝ)))^[m n + 1] v - T.stoneU t v
      = ((cnStep (S n) (t / ((m n + 1 : ℕ) : ℝ)))^[m n + 1] v - (S n).stoneU t v)
        + ((S n).stoneU t v - T.stoneU t v) := by
    abel
  have htri := norm_add_le
    ((cnStep (S n) (t / ((m n + 1 : ℕ) : ℝ)))^[m n + 1] v - (S n).stoneU t v)
    ((S n).stoneU t v - T.stoneU t v)
  rw [dist_eq_norm, hsplit]
  linarith
