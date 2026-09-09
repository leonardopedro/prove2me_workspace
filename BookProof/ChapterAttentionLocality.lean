import Mathlib
import BookProof.ChapterAttentionSparse

/-!
# Chapter "The Coherent State of Attention": a distance penalty makes a head local

Position information is often injected as a *penalty* rather than as an embedding:
the score of a key is reduced in proportion to its distance from the query
(`sₗ ↦ sₗ − γ·dₗ`).  This module proves that such a head is genuinely local — the
attention it can place at distance `R` decays exponentially in `R` — and that the
resulting sliding-window approximation is therefore exponentially accurate.

Throughout, `d : Fin m → ℝ` is the distance of each key from the query, `γ ≥ 0` the
penalty slope, and `j₀` a key at distance `0` whose score is within `Δ` of every
other raw score.

* `alibiScore` — the penalized score family;
* `scoreSoftmax_alibi_antitone` — with equal raw scores, the nearer key always wins;
* **`scoreSoftmax_alibi_le`** — the headline decay law:
  `pₗ ≤ e^{βΔ}·e^{−βγ dₗ}`;
* `farMass_le` — hence the total attention beyond distance `R` is at most
  `m·e^{βΔ}·e^{−βγR}`;
* `norm_headOutput_window_sub_le` — and the windowed head (attention restricted to
  the keys within distance `R`) is within `2C·m·e^{βΔ}·e^{−βγR}` of the full head:
  a sliding window is not an approximation one has to apologize for.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionLocality

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterAttentionMasking BookProof.ChapterAttentionMarkov
  BookProof.ChapterObservableExpectation BookProof.ChapterAttentionOutput
  BookProof.ChapterAttentionSparse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-! ## The penalized head -/

/-- The **distance-penalized score**: the raw alignment score of a key reduced in
proportion to its distance from the query. -/
def alibiScore (s : Fin m → ℝ) (gamma : ℝ) (d : Fin m → ℝ) (l : Fin m) : ℝ :=
  s l - gamma * d l

/-- **The nearer key wins.**  At equal raw scores the penalized head prefers the
closer key. -/
theorem scoreSoftmax_alibi_antitone {beta gamma : ℝ} (hb : 0 ≤ beta) (hg : 0 ≤ gamma)
    (c : ℝ) (d : Fin m → ℝ) {i j : Fin m} (hij : d i ≤ d j) :
    scoreSoftmax beta (alibiScore (fun _ => c) gamma d) j
      ≤ scoreSoftmax beta (alibiScore (fun _ => c) gamma d) i := by
  rw [scoreSoftmax, scoreSoftmax]
  refine div_le_div_of_nonneg_right ?_ (scoreSoftmax_denom_pos beta _ i).le
  refine Real.exp_le_exp.2 (mul_le_mul_of_nonneg_left ?_ hb)
  have : gamma * d i ≤ gamma * d j := mul_le_mul_of_nonneg_left hij hg
  simp only [alibiScore]
  linarith

/-! ## The decay law -/

/-- **HEADLINE — attention decays exponentially with distance.**  If some key `j₀`
sits at distance `0` and no raw score exceeds `s j₀ + Δ`, then every key `l` of the
penalized head carries at most `e^{βΔ}·e^{−βγ dₗ}`. -/
theorem scoreSoftmax_alibi_le {beta gamma Delta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (d : Fin m → ℝ) {j₀ : Fin m} (hd0 : d j₀ = 0) (hDelta : ∀ l, s l ≤ s j₀ + Delta)
    (l : Fin m) :
    scoreSoftmax beta (alibiScore s gamma d) l
      ≤ Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * d l))) := by
  set t := alibiScore s gamma d with ht
  have hZ : 0 < ∑ x, Real.exp (beta * t x) := scoreSoftmax_denom_pos beta t l
  have hden : Real.exp (beta * t j₀) ≤ ∑ x, Real.exp (beta * t x) :=
    Finset.single_le_sum (f := fun x => Real.exp (beta * t x))
      (fun x _ => (Real.exp_pos _).le) (Finset.mem_univ j₀)
  have hnum : Real.exp (beta * t l)
      ≤ Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * d l)))
        * Real.exp (beta * t j₀) := by
    rw [← Real.exp_add, ← Real.exp_add, Real.exp_le_exp]
    have hj : t j₀ = s j₀ := by simp [ht, alibiScore, hd0]
    have hl : t l = s l - gamma * d l := rfl
    have := hDelta l
    rw [hj, hl]
    nlinarith [hb, this]
  calc scoreSoftmax beta t l = Real.exp (beta * t l) / ∑ x, Real.exp (beta * t x) := rfl
    _ ≤ (Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * d l)))
          * Real.exp (beta * t j₀)) / ∑ x, Real.exp (beta * t x) :=
        div_le_div_of_nonneg_right hnum hZ.le
    _ ≤ Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * d l))) := by
        rw [div_le_iff₀ hZ]
        have hpos : 0 ≤ Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * d l))) :=
          (mul_pos (Real.exp_pos _) (Real.exp_pos _)).le
        exact mul_le_mul_of_nonneg_left hden hpos

/-- The keys within distance `R` of the query: the sliding window. -/
def window (d : Fin m → ℝ) (R : ℝ) : Finset (Fin m) :=
  Finset.univ.filter fun l => d l < R

theorem mem_window {d : Fin m → ℝ} {R : ℝ} {l : Fin m} : l ∈ window d R ↔ d l < R := by
  simp [window]

/-- **The attention beyond distance `R` is exponentially small.** -/
theorem farMass_le {beta gamma Delta R : ℝ} (hb : 0 ≤ beta) (hg : 0 ≤ gamma)
    (s : Fin m → ℝ) (d : Fin m → ℝ) {j₀ : Fin m} (hd0 : d j₀ = 0)
    (hDelta : ∀ l, s l ≤ s j₀ + Delta) :
    ∑ l ∈ (window d R)ᶜ, scoreSoftmax beta (alibiScore s gamma d) l
      ≤ (m : ℝ) * (Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * R)))) := by
  have hterm : ∀ l ∈ (window d R)ᶜ,
      scoreSoftmax beta (alibiScore s gamma d) l
        ≤ Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * R))) := by
    intro l hl
    have hfar : R ≤ d l := by
      have := Finset.mem_compl.1 hl
      rw [mem_window] at this
      linarith [not_lt.1 this]
    refine le_trans (scoreSoftmax_alibi_le hb s d hd0 hDelta l) ?_
    refine mul_le_mul_of_nonneg_left (Real.exp_le_exp.2 ?_) (Real.exp_pos _).le
    have : gamma * R ≤ gamma * d l := mul_le_mul_of_nonneg_left hfar hg
    nlinarith [hb]
  calc ∑ l ∈ (window d R)ᶜ, scoreSoftmax beta (alibiScore s gamma d) l
      ≤ ∑ _l ∈ (window d R)ᶜ,
          Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * R))) :=
        Finset.sum_le_sum hterm
    _ = ((window d R)ᶜ.card : ℝ)
          * (Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * R)))) := by
        rw [Finset.sum_const, nsmul_eq_mul]
    _ ≤ (m : ℝ) * (Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * R)))) := by
        refine mul_le_mul_of_nonneg_right ?_
          (mul_pos (Real.exp_pos _) (Real.exp_pos _)).le
        have : (window d R)ᶜ.card ≤ m := by
          simpa using Finset.card_le_card (Finset.subset_univ ((window d R)ᶜ))
        exact_mod_cast this

/-! ## The sliding window is exponentially accurate -/

/-- **A sliding window is an exponentially good approximation.**  Restricting a
distance-penalized head to the keys within distance `R` changes its output by at
most `2C·m·e^{βΔ}·e^{−βγR}`. -/
theorem norm_headOutput_window_sub_le {beta gamma Delta R : ℝ} (hb : 0 ≤ beta)
    (hg : 0 ≤ gamma) (s : Fin m → ℝ) (d : Fin m → ℝ) {j₀ : Fin m} (hd0 : d j₀ = 0)
    (hR : 0 < R) (hDelta : ∀ l, s l ≤ s j₀ + Delta) {v : Fin m → E} {C : ℝ}
    (hv : ∀ j, ‖v j‖ ≤ C) (hC : 0 ≤ C) :
    ‖observableExpectation
        (maskedSoftmax beta (alibiScore s gamma d) (window d R)) v
      - headOutput beta (alibiScore s gamma d) v‖
      ≤ 2 * ((m : ℝ) * (Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * R))))) * C := by
  have hj₀ : j₀ ∈ window d R := by rw [mem_window, hd0]; exact hR
  have hS : (window d R).Nonempty := ⟨j₀, hj₀⟩
  have hfar := farMass_le hb hg s d hd0 hDelta (R := R)
  have hmass : 1 - attendedMass beta (alibiScore s gamma d) (window d R)
      ≤ (m : ℝ) * (Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * R)))) := by
    rw [one_sub_attendedMass_eq beta (alibiScore s gamma d) (window d R) j₀]
    exact hfar
  refine le_trans
    (norm_headOutput_masked_sub_le beta (alibiScore s gamma d) hS j₀ hv) ?_
  have h2 : 2 * (1 - attendedMass beta (alibiScore s gamma d) (window d R))
      ≤ 2 * ((m : ℝ) * (Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * R))))) := by
    linarith
  exact mul_le_mul_of_nonneg_right h2 hC

end BookProof.ChapterAttentionLocality

end
