import Mathlib
import BookProof.ChapterSirkRitzMinMax

/-!
# Chapter SirkRitzPerturbation — the min–max levels are 1-Lipschitz, and a gap survives a
perturbation

`BookProof.ChapterSirkRitzMinMax` built the Courant–Fischer levels `minmaxLevel T k` of a
bounded operator and proved that the Galerkin (Rayleigh–Ritz) levels of the truncations
converge to them, so that the *computed* gap converges to the min–max gap.  That statement
is about **one** operator: the exact one.  A solver never holds the exact operator — it
holds a model of it (a truncated coupling, a rounded matrix, a regularized potential).
`CONSOLIDATED_PLAN.md` §12.2 Gap 2 and §13 therefore need the *stability* half: how far can
the levels move when the operator moves?

This chapter answers that: **every Courant–Fischer level is 1-Lipschitz in the operator
norm**, so the gap is 2-Lipschitz, and a gap that exceeds twice the modelling error is a
genuine gap of the exact operator.

## Deliverables

* `rayleighVal_sub_le_dist`, `abs_rayleighVal_sub_le_dist`, `rayleighSup_le_rayleighSup_add`,
  `abs_rayleighSup_sub_le_dist` — the elementary layer: on the unit sphere the Rayleigh
  quotients, and hence the tops of the numerical ranges on any subspace, move by at most
  `‖T − T'‖`.
* `minmaxSet_nonempty_congr` / `minmaxSetIn_nonempty_congr` — the min–max sets are nonempty
  for one operator iff for all of them: nonemptiness is a statement about the *dimensions*
  available in the space, not about the operator.
* **`abs_minmaxLevel_sub_le_dist`** — the headline: `|Λ_k(T) − Λ_k(T')| ≤ ‖T − T'‖`.
* **`abs_minmaxLevelIn_sub_le_dist`** — the same for the Ritz levels computed inside a fixed
  truncation `W`, and **`minmaxLevel_le_minmaxLevelIn_add`**: a Ritz level computed in `W`
  for the *model* operator is an upper bound for the exact level of the true operator, up to
  the operator error.  This is the form a certificate takes.
* `minmaxLevel_mono_form` — monotonicity in the form order, `minmaxLevel_le_norm` /
  `neg_norm_le_minmaxLevel` — the levels lie in `[−‖T‖, ‖T‖]`.
* `shiftOp`, `rayleighVal_shiftOp`, `rayleighSup_shiftOp`, **`minmaxLevel_shiftOp`** — a real
  shift shifts every level, `Λ_k(T + c) = Λ_k(T) + c`, hence **`minmaxGap_shiftOp`**: the gap
  is invariant under the shift a shift-invert scheme applies.
* `minmaxGap`, `minmaxGap_nonneg`, `abs_minmaxGap_sub_le` — the gap and its 2-Lipschitz
  bound; **`minmaxGap_ge_of_dist_le`** and **`minmaxGap_pos_of_dist_lt`**: a gap survives a
  perturbation of less than half its size.
* **`minmaxLevel_tendsto_of_tendsto`** / `minmaxGap_tendsto_of_tendsto` — norm convergence of
  a family of operators forces convergence of every level, and of the gap.
* **`galerkin_model_gap_tendsto`** — what a solver running on the model operator computes:
  its Galerkin gaps converge, and the limit is within `2ε` of the true gap.
* **`galerkin_model_gap_eventually_pos`** — a true gap larger than twice the modelling error
  is eventually seen by the truncations of the model operator.
* **`abs_sInf_spectrum_sub_le_dist`** — through the level-zero identification of
  `ChapterSirkRitzMinMax`, the bottom of the spectrum of a bounded self-adjoint operator is
  1-Lipschitz in the operator norm.

## Honest boundary

Everything here is for **bounded** operators, and the distance used is the operator norm: a
perturbation that is only relatively bounded, or only strongly convergent, is not covered.
The certified direction is the one the variational principle gives: computed Ritz levels are
**upper** bounds.  Nothing here turns a positive *computed* truncated gap into a positive
gap of the exact operator — that needs a lower bound on the first excited level (a residual
estimate), not merely the min–max inequality; `galerkin_model_gap_eventually_pos` runs in
the sound direction, from a true gap to what the truncations of the model eventually show.
-/

noncomputable section

namespace BookProof.RitzPerturbation

open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

omit [CompleteSpace F] in
/-- The Rayleigh quotients of two operators differ by at most the operator distance. -/
theorem rayleighVal_sub_le_dist (T T' : F →L[ℂ] F) {x : F} (hx1 : ‖x‖ = 1) :
    rayleighVal T x - rayleighVal T' x ≤ ‖T - T'‖ := by
  have hsplit : rayleighVal T x - rayleighVal T' x = (inner ℂ x ((T - T') x) : ℂ).re := by
    simp [rayleighVal]
  rw [hsplit]
  calc (inner ℂ x ((T - T') x) : ℂ).re ≤ ‖(inner ℂ x ((T - T') x) : ℂ)‖ := Complex.re_le_norm _
    _ ≤ ‖x‖ * ‖(T - T') x‖ := norm_inner_le_norm _ _
    _ ≤ ‖T - T'‖ := by
        have h := (T - T').le_opNorm x
        rw [hx1, mul_one] at h
        rw [hx1, one_mul]
        exact h

omit [CompleteSpace F] in
theorem abs_rayleighVal_sub_le_dist (T T' : F →L[ℂ] F) {x : F} (hx1 : ‖x‖ = 1) :
    |rayleighVal T x - rayleighVal T' x| ≤ ‖T - T'‖ := by
  refine abs_sub_le_iff.mpr ⟨rayleighVal_sub_le_dist T T' hx1, ?_⟩
  have h := rayleighVal_sub_le_dist T' T hx1
  rwa [← neg_sub T T', norm_neg] at h

omit [CompleteSpace F] in
/-- The tops of the numerical ranges on a subspace differ by at most the operator
distance. -/
theorem rayleighSup_le_rayleighSup_add (T T' : F →L[ℂ] F) {S : Submodule ℂ F}
    (hS : 0 < Module.finrank ℂ S) :
    rayleighSup T S ≤ rayleighSup T' S + ‖T - T'‖ := by
  refine csSup_le (rayleighSetOn_nonempty T hS) ?_
  rintro t ⟨x, hx, hx1, rfl⟩
  have h1 : rayleighVal T' x ≤ rayleighSup T' S := rayleighVal_le_rayleighSup T' hx hx1
  have h2 := rayleighVal_sub_le_dist T T' hx1
  linarith

omit [CompleteSpace F] in
theorem abs_rayleighSup_sub_le_dist (T T' : F →L[ℂ] F) {S : Submodule ℂ F}
    (hS : 0 < Module.finrank ℂ S) :
    |rayleighSup T S - rayleighSup T' S| ≤ ‖T - T'‖ := by
  refine abs_sub_le_iff.mpr ⟨by linarith [rayleighSup_le_rayleighSup_add T T' hS], ?_⟩
  have h := rayleighSup_le_rayleighSup_add T' T hS
  rw [← neg_sub T T', norm_neg] at h
  linarith

/-! ## The min–max levels are 1-Lipschitz -/

omit [CompleteSpace F] in
/-- Whether the `k`-th min–max set is nonempty does not depend on the operator: it only
records that the space has subspaces of dimension `k + 1`. -/
theorem minmaxSet_nonempty_congr (T T' : F →L[ℂ] F) {k : ℕ}
    (h : (minmaxSet T k).Nonempty) : (minmaxSet T' k).Nonempty := by
  obtain ⟨t, S, hrank, -⟩ := h
  exact ⟨rayleighSup T' S, S, hrank, rfl⟩

omit [CompleteSpace F] in
theorem minmaxLevel_le_minmaxLevel_add (T T' : F →L[ℂ] F) (k : ℕ)
    (hne : (minmaxSet T' k).Nonempty) :
    minmaxLevel T k ≤ minmaxLevel T' k + ‖T - T'‖ := by
  have key : minmaxLevel T k - ‖T - T'‖ ≤ minmaxLevel T' k := by
    refine le_csInf hne ?_
    rintro t ⟨S, hrank, rfl⟩
    have hpos : 0 < Module.finrank ℂ S := by rw [hrank]; omega
    have h1 : minmaxLevel T k ≤ rayleighSup T S :=
      csInf_le (minmaxSet_bddBelow T k) ⟨S, hrank, rfl⟩
    have h2 := rayleighSup_le_rayleighSup_add T T' hpos
    linarith
  linarith

omit [CompleteSpace F] in
/-- **The Courant–Fischer levels are 1-Lipschitz in the operator norm.** -/
theorem abs_minmaxLevel_sub_le_dist (T T' : F →L[ℂ] F) (k : ℕ)
    (hne : (minmaxSet T k).Nonempty) :
    |minmaxLevel T k - minmaxLevel T' k| ≤ ‖T - T'‖ := by
  have hne' : (minmaxSet T' k).Nonempty := minmaxSet_nonempty_congr T T' hne
  refine abs_sub_le_iff.mpr ⟨by linarith [minmaxLevel_le_minmaxLevel_add T T' k hne'], ?_⟩
  have h := minmaxLevel_le_minmaxLevel_add T' T k hne
  rw [← neg_sub T T', norm_neg] at h
  linarith

omit [CompleteSpace F] in
theorem minmaxSetIn_nonempty_congr (T T' : F →L[ℂ] F) {W : Submodule ℂ F} {k : ℕ}
    (h : (minmaxSetIn T W k).Nonempty) : (minmaxSetIn T' W k).Nonempty := by
  obtain ⟨t, S, hSW, hrank, -⟩ := h
  exact ⟨rayleighSup T' S, S, hSW, hrank, rfl⟩

omit [CompleteSpace F] in
theorem minmaxLevelIn_le_minmaxLevelIn_add (T T' : F →L[ℂ] F) (W : Submodule ℂ F) (k : ℕ)
    (hne : (minmaxSetIn T' W k).Nonempty) :
    minmaxLevelIn T W k ≤ minmaxLevelIn T' W k + ‖T - T'‖ := by
  have key : minmaxLevelIn T W k - ‖T - T'‖ ≤ minmaxLevelIn T' W k := by
    refine le_csInf hne ?_
    rintro t ⟨S, hSW, hrank, rfl⟩
    have hpos : 0 < Module.finrank ℂ S := by rw [hrank]; omega
    have h1 : minmaxLevelIn T W k ≤ rayleighSup T S :=
      csInf_le (minmaxSetIn_bddBelow T W k) ⟨S, hSW, hrank, rfl⟩
    have h2 := rayleighSup_le_rayleighSup_add T T' hpos
    linarith
  linarith

omit [CompleteSpace F] in
/-- **The Ritz levels of a truncation are 1-Lipschitz in the operator norm.** -/
theorem abs_minmaxLevelIn_sub_le_dist (T T' : F →L[ℂ] F) (W : Submodule ℂ F) (k : ℕ)
    (hne : (minmaxSetIn T W k).Nonempty) :
    |minmaxLevelIn T W k - minmaxLevelIn T' W k| ≤ ‖T - T'‖ := by
  have hne' : (minmaxSetIn T' W k).Nonempty := minmaxSetIn_nonempty_congr T T' hne
  refine abs_sub_le_iff.mpr ⟨by linarith [minmaxLevelIn_le_minmaxLevelIn_add T T' W k hne'], ?_⟩
  have h := minmaxLevelIn_le_minmaxLevelIn_add T' T W k hne
  rw [← neg_sub T T', norm_neg] at h
  linarith

omit [CompleteSpace F] in
/-- **The certified upper bound**: a Ritz level computed inside a truncation `W` for an
*approximate* operator `T'` is an upper bound for the exact min–max level of `T`, up to
the operator error. -/
theorem minmaxLevel_le_minmaxLevelIn_add (T T' : F →L[ℂ] F) (W : Submodule ℂ F) (k : ℕ)
    (hne : (minmaxSetIn T' W k).Nonempty) :
    minmaxLevel T k ≤ minmaxLevelIn T' W k + ‖T - T'‖ := by
  have h1 : minmaxLevel T k ≤ minmaxLevelIn T W k :=
    minmaxLevel_le_minmaxLevelIn T W k (minmaxSetIn_nonempty_congr T' T hne)
  have h2 := minmaxLevelIn_le_minmaxLevelIn_add T T' W k hne
  linarith

/-! ## The order on the forms -/

omit [CompleteSpace F] in
/-- Monotonicity of the levels in the form order. -/
theorem minmaxLevel_mono_form (T T' : F →L[ℂ] F) (k : ℕ)
    (hle : ∀ x : F, rayleighVal T x ≤ rayleighVal T' x)
    (hne : (minmaxSet T' k).Nonempty) :
    minmaxLevel T k ≤ minmaxLevel T' k := by
  refine le_csInf hne ?_
  rintro t ⟨S, hrank, rfl⟩
  have hpos : 0 < Module.finrank ℂ S := by rw [hrank]; omega
  have h1 : minmaxLevel T k ≤ rayleighSup T S :=
    csInf_le (minmaxSet_bddBelow T k) ⟨S, hrank, rfl⟩
  have h2 : rayleighSup T S ≤ rayleighSup T' S := by
    refine csSup_le (rayleighSetOn_nonempty T hpos) ?_
    rintro s ⟨x, hx, hx1, rfl⟩
    exact (hle x).trans (rayleighVal_le_rayleighSup T' hx hx1)
  linarith

/-! ## The gap -/

/-- The min–max gap: the distance from the first excited level to the ground level. -/
def minmaxGap (T : F →L[ℂ] F) : ℝ := minmaxLevel T 1 - minmaxLevel T 0

omit [CompleteSpace F] in
/-- **A certified gap survives a perturbation of less than half its size.** -/
theorem minmaxGap_ge_of_dist_le (T T' : F →L[ℂ] F) {eps : ℝ} (hd : ‖T - T'‖ ≤ eps)
    (hne0 : (minmaxSet T 0).Nonempty) (hne1 : (minmaxSet T 1).Nonempty) :
    minmaxGap T' - 2 * eps ≤ minmaxGap T := by
  have h0 := abs_minmaxLevel_sub_le_dist T T' 0 hne0
  have h1 := abs_minmaxLevel_sub_le_dist T T' 1 hne1
  rw [abs_sub_le_iff] at h0 h1
  simp only [minmaxGap]
  linarith [h0.1, h0.2, h1.1, h1.2, hd]

omit [CompleteSpace F] in
theorem minmaxGap_pos_of_dist_lt (T T' : F →L[ℂ] F) {eps : ℝ} (hd : ‖T - T'‖ ≤ eps)
    (hgap : 2 * eps < minmaxGap T')
    (hne0 : (minmaxSet T 0).Nonempty) (hne1 : (minmaxSet T 1).Nonempty) :
    0 < minmaxGap T := by
  have h := minmaxGap_ge_of_dist_le T T' hd hne0 hne1
  linarith

/-- **The bottom of the spectrum is 1-Lipschitz** in the operator norm, for bounded
self-adjoint operators. -/
theorem abs_sInf_spectrum_sub_le_dist [Nontrivial F] (T T' : F →L[ℂ] F)
    (hT : IsSelfAdjoint T) (hT' : IsSelfAdjoint T')
    (hne : (minmaxSet T 0).Nonempty) :
    |sInf (spectrum ℝ T) - sInf (spectrum ℝ T')| ≤ ‖T - T'‖ := by
  rw [← minmaxLevel_zero_eq_sInf_spectrum T hT, ← minmaxLevel_zero_eq_sInf_spectrum T' hT']
  exact abs_minmaxLevel_sub_le_dist T T' 0 hne

/-- The real shift `T + c` of a bounded operator. -/
def shiftOp (T : F →L[ℂ] F) (c : ℝ) : F →L[ℂ] F :=
  T + (c : ℂ) • ContinuousLinearMap.id ℂ F

omit [CompleteSpace F] in
theorem rayleighVal_shiftOp (T : F →L[ℂ] F) (c : ℝ) {x : F} (hx1 : ‖x‖ = 1) :
    rayleighVal (shiftOp T c) x = rayleighVal T x + c := by
  have hxx : (inner ℂ x x : ℂ) = 1 := by
    rw [inner_self_eq_norm_sq_to_K, hx1]
    norm_num
  have happ : (shiftOp T c) x = T x + (c : ℂ) • x := by simp [shiftOp]
  rw [rayleighVal, happ, inner_add_right, inner_smul_right, hxx, mul_one, Complex.add_re]
  simp [rayleighVal]

omit [CompleteSpace F] in
theorem rayleighSup_shiftOp (T : F →L[ℂ] F) (c : ℝ) {S : Submodule ℂ F}
    (hS : 0 < Module.finrank ℂ S) :
    rayleighSup (shiftOp T c) S = rayleighSup T S + c := by
  refine le_antisymm ?_ ?_
  · refine csSup_le (rayleighSetOn_nonempty _ hS) ?_
    rintro t ⟨x, hx, hx1, rfl⟩
    rw [rayleighVal_shiftOp T c hx1]
    have := rayleighVal_le_rayleighSup T hx hx1
    linarith
  · have : rayleighSup T S ≤ rayleighSup (shiftOp T c) S - c := by
      refine csSup_le (rayleighSetOn_nonempty T hS) ?_
      rintro t ⟨x, hx, hx1, rfl⟩
      have h := rayleighVal_le_rayleighSup (shiftOp T c) hx hx1
      rw [rayleighVal_shiftOp T c hx1] at h
      linarith
    linarith

omit [CompleteSpace F] in
/-- **A real shift shifts the levels**: `Λ_k(T + c) = Λ_k(T) + c`. -/
theorem minmaxLevel_shiftOp (T : F →L[ℂ] F) (c : ℝ) (k : ℕ)
    (hne : (minmaxSet T k).Nonempty) :
    minmaxLevel (shiftOp T c) k = minmaxLevel T k + c := by
  have hne' : (minmaxSet (shiftOp T c) k).Nonempty := minmaxSet_nonempty_congr T _ hne
  refine le_antisymm ?_ ?_
  · have key : minmaxLevel (shiftOp T c) k - c ≤ minmaxLevel T k := by
      refine le_csInf hne ?_
      rintro t ⟨S, hrank, rfl⟩
      have hpos : 0 < Module.finrank ℂ S := by rw [hrank]; omega
      have h : minmaxLevel (shiftOp T c) k ≤ rayleighSup (shiftOp T c) S :=
        csInf_le (minmaxSet_bddBelow (shiftOp T c) k) ⟨S, hrank, rfl⟩
      rw [rayleighSup_shiftOp T c hpos] at h
      linarith
    linarith
  · have key : minmaxLevel T k + c ≤ minmaxLevel (shiftOp T c) k := by
      refine le_csInf hne' ?_
      rintro t ⟨S, hrank, rfl⟩
      have hpos : 0 < Module.finrank ℂ S := by rw [hrank]; omega
      have h : minmaxLevel T k ≤ rayleighSup T S :=
        csInf_le (minmaxSet_bddBelow T k) ⟨S, hrank, rfl⟩
      rw [rayleighSup_shiftOp T c hpos]
      linarith
    linarith

omit [CompleteSpace F] in
/-- **The gap is shift-invariant** — the Hashimoto shift does not move it. -/
theorem minmaxGap_shiftOp (T : F →L[ℂ] F) (c : ℝ)
    (hne0 : (minmaxSet T 0).Nonempty) (hne1 : (minmaxSet T 1).Nonempty) :
    minmaxGap (shiftOp T c) = minmaxGap T := by
  simp only [minmaxGap, minmaxLevel_shiftOp T c 0 hne0, minmaxLevel_shiftOp T c 1 hne1]
  ring

omit [CompleteSpace F] in
/-- The gap of two operators differs by at most twice the operator distance. -/
theorem abs_minmaxGap_sub_le (T T' : F →L[ℂ] F)
    (hne0 : (minmaxSet T 0).Nonempty) (hne1 : (minmaxSet T 1).Nonempty) :
    |minmaxGap T - minmaxGap T'| ≤ 2 * ‖T - T'‖ := by
  have h0 := abs_minmaxLevel_sub_le_dist T T' 0 hne0
  have h1 := abs_minmaxLevel_sub_le_dist T T' 1 hne1
  rw [abs_sub_le_iff] at h0 h1 ⊢
  constructor <;> simp only [minmaxGap] <;> linarith [h0.1, h0.2, h1.1, h1.2]

omit [CompleteSpace F] in
/-- **Norm convergence of the operators forces convergence of every level.** -/
theorem minmaxLevel_tendsto_of_tendsto {ι : Type*} {l : Filter ι} (Tn : ι → F →L[ℂ] F)
    (T : F →L[ℂ] F) (k : ℕ) (hne : (minmaxSet T k).Nonempty)
    (h : Tendsto (fun i => ‖Tn i - T‖) l (𝓝 0)) :
    Tendsto (fun i => minmaxLevel (Tn i) k) l (𝓝 (minmaxLevel T k)) := by
  rw [tendsto_iff_dist_tendsto_zero]
  refine squeeze_zero (fun i => dist_nonneg) (fun i => ?_) h
  rw [Real.dist_eq]
  exact abs_minmaxLevel_sub_le_dist (Tn i) T k (minmaxSet_nonempty_congr T _ hne)

omit [CompleteSpace F] in
/-- The same for the gap. -/
theorem minmaxGap_tendsto_of_tendsto {ι : Type*} {l : Filter ι} (Tn : ι → F →L[ℂ] F)
    (T : F →L[ℂ] F) (hne0 : (minmaxSet T 0).Nonempty) (hne1 : (minmaxSet T 1).Nonempty)
    (h : Tendsto (fun i => ‖Tn i - T‖) l (𝓝 0)) :
    Tendsto (fun i => minmaxGap (Tn i)) l (𝓝 (minmaxGap T)) := by
  have h0 := minmaxLevel_tendsto_of_tendsto Tn T 0 hne0 h
  have h1 := minmaxLevel_tendsto_of_tendsto Tn T 1 hne1 h
  simpa [minmaxGap] using h1.sub h0


omit [CompleteSpace F] in
/-- Every level is bounded by the operator norm. -/
theorem minmaxLevel_le_norm (T : F →L[ℂ] F) (k : ℕ) (hne : (minmaxSet T k).Nonempty) :
    minmaxLevel T k ≤ ‖T‖ := by
  obtain ⟨t, S, hrank, rfl⟩ := hne
  exact (csInf_le (minmaxSet_bddBelow T k) ⟨S, hrank, rfl⟩).trans (rayleighSup_le_norm T S)

omit [CompleteSpace F] in
theorem neg_norm_le_minmaxLevel (T : F →L[ℂ] F) (k : ℕ) (hne : (minmaxSet T k).Nonempty) :
    -‖T‖ ≤ minmaxLevel T k := by
  refine le_csInf hne ?_
  rintro t ⟨S, hrank, rfl⟩
  exact neg_norm_le_rayleighSup T (by rw [hrank]; omega)

omit [CompleteSpace F] in
/-- The gap is non-negative: the levels increase with `k`. -/
theorem minmaxGap_nonneg (T : F →L[ℂ] F) (hne1 : (minmaxSet T 1).Nonempty) :
    0 ≤ minmaxGap T := by
  have := minmaxLevel_mono T (Nat.zero_le 1) hne1
  simp only [minmaxGap]
  linarith

/-! ## What a solver running on the model operator computes -/

omit [CompleteSpace F] in
/-- **The Galerkin gaps of a model operator converge, and the limit is within `2ε` of the
true gap.**  `T` is the exact operator, `T'` the operator the solver actually holds. -/
theorem galerkin_model_gap_tendsto (T T' : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) {eps : ℝ}
    (hd : ‖T - T'‖ ≤ eps) :
    Tendsto (fun m : ℕ => minmaxLevelIn T' (galerkinSpan b m) 1
        - minmaxLevelIn T' (galerkinSpan b m) 0) atTop (𝓝 (minmaxGap T')) ∧
      |minmaxGap T' - minmaxGap T| ≤ 2 * eps := by
  refine ⟨galerkin_gap_tendsto T' b, ?_⟩
  have h := abs_minmaxGap_sub_le T' T (minmaxSet_nonempty T' b 0) (minmaxSet_nonempty T' b 1)
  rw [← neg_sub T T', norm_neg] at h
  linarith [h, abs_nonneg (minmaxGap T' - minmaxGap T)]

omit [CompleteSpace F] in
/-- **A true gap larger than twice the modelling error is eventually seen by the
truncations of the model operator.** -/
theorem galerkin_model_gap_eventually_pos (T T' : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F)
    {eps : ℝ} (hd : ‖T - T'‖ ≤ eps) (hgap : 2 * eps < minmaxGap T) :
    ∀ᶠ m : ℕ in atTop, 0 < minmaxLevelIn T' (galerkinSpan b m) 1
      - minmaxLevelIn T' (galerkinSpan b m) 0 := by
  have h := abs_minmaxGap_sub_le T' T (minmaxSet_nonempty T' b 0) (minmaxSet_nonempty T' b 1)
  rw [← neg_sub T T', norm_neg, abs_sub_le_iff] at h
  refine galerkin_gap_eventually_pos T' b ?_
  have hle : minmaxGap T - 2 * eps ≤ minmaxGap T' := by linarith [h.2]
  simp only [minmaxGap] at hle hgap
  linarith

end BookProof.RitzPerturbation
