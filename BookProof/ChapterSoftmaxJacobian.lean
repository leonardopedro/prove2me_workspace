import Mathlib
import BookProof.ChapterSoftmaxFluctuation

/-!
# Chapter "The Coherent State of Attention" — the score derivative of attention

`ChapterSoftmaxFluctuation` differentiates the attention distribution in the
*inverse temperature* `β`.  This module differentiates it in the *scores*
themselves: the alignment score `sᵢ` of a single key is nudged, and the response
of the free energy and of every attention weight is computed.  This is the
Jacobian that backpropagation through an attention head actually uses.

Deliverables (all `sorry`-free, `axiom`-free):

* `scorePerturb s i t` — the score profile `s` with `t` added to the `i`-th score
  only;
* `hasDerivAt_partition_score`, `hasDerivAt_logPartition_score` — **attention is
  the score gradient of the free energy**: `∂/∂sᵢ log Z = β·pᵢ`;
* `hasDerivAt_scoreSoftmax_score` — **the Jacobian of Softmax**:
  `∂pⱼ/∂sᵢ = β·pⱼ·(δᵢⱼ − pᵢ)`;
* `softmaxJacobian` and its structural laws: `softmaxJacobian_symm` (the Jacobian
  is symmetric, as a Hessian of `log Z` must be), `softmaxJacobian_row_sum_zero`
  (the total weight is conserved: a key can only gain what the others lose),
  `softmaxJacobian_diag_nonneg` / `softmaxJacobian_offDiag_nonpos` (raising a
  score helps that key and hurts every other one, at `β ≥ 0`);
* `softmaxJacobian_quadratic_form` — the quadratic form of the Jacobian is
  `β` times the attention-weighted variance of the test vector, hence
  `softmaxJacobian_posSemidef` at `β ≥ 0`;
* `softmaxJacobian_quadratic_form_score` — evaluated on the scores themselves it
  returns `β·Var_β(s)`, tying the score Jacobian to the fluctuation–response law
  of `ChapterSoftmaxFluctuation`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterSoftmaxJacobian

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterSoftmaxFluctuation

variable {m : ℕ}

/-! ## Perturbing a single score -/

/-- The score profile `s` with `t` added to the score of the key `i` only. -/
def scorePerturb (s : Fin m → ℝ) (i : Fin m) (t : ℝ) : Fin m → ℝ :=
  fun l => s l + (if l = i then t else 0)

@[simp] theorem scorePerturb_zero (s : Fin m → ℝ) (i : Fin m) : scorePerturb s i 0 = s := by
  funext l
  simp [scorePerturb]

theorem scorePerturb_self (s : Fin m → ℝ) (i : Fin m) (t : ℝ) :
    scorePerturb s i t i = s i + t := by
  simp [scorePerturb]

theorem scorePerturb_of_ne (s : Fin m → ℝ) {i l : Fin m} (h : l ≠ i) (t : ℝ) :
    scorePerturb s i t l = s l := by
  simp [scorePerturb, h]

/-! ## Differentiating the partition function in a score -/

theorem hasDerivAt_exp_score (beta t₀ : ℝ) (c : ℝ) :
    HasDerivAt (fun t : ℝ => Real.exp (beta * (c + t)))
      (beta * Real.exp (beta * (c + t₀))) t₀ := by
  have h : HasDerivAt (fun t : ℝ => beta * (c + t)) beta t₀ := by
    simpa using ((hasDerivAt_id t₀).const_add c).const_mul beta
  simpa [mul_comm] using h.exp

/-- The partition function responds to a single score with the unnormalized
Boltzmann factor of that key. -/
theorem hasDerivAt_partition_score (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    HasDerivAt (fun t : ℝ => partition beta (scorePerturb s i t))
      (beta * Real.exp (beta * s i)) 0 := by
  have h : HasDerivAt (fun t : ℝ => ∑ l, Real.exp (beta * scorePerturb s i t l))
      (∑ l, if l = i then beta * Real.exp (beta * s i) else 0) 0 := by
    refine HasDerivAt.fun_sum fun l _ => ?_
    by_cases hl : l = i
    · subst hl
      simpa [scorePerturb] using hasDerivAt_exp_score beta 0 (s l)
    · simpa [scorePerturb, hl] using
        (hasDerivAt_const (0 : ℝ) (Real.exp (beta * s l)))
  simpa [partition] using h

/-- **Attention is the score gradient of the free energy.**  Nudging the alignment
score of the key `i` changes `log Z` at rate `β·pᵢ`: the attention weight of a key
*is* the sensitivity of the free energy to that key's score. -/
theorem hasDerivAt_logPartition_score (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    HasDerivAt (fun t : ℝ => logPartition beta (scorePerturb s i t))
      (beta * scoreSoftmax beta s i) 0 := by
  have hne := partition_ne_zero beta s i
  have h := (hasDerivAt_partition_score beta s i).log (by simpa using hne)
  refine h.congr_deriv ?_
  rw [scoreSoftmax_eq_div]
  simp [mul_div_assoc]

theorem deriv_logPartition_score (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    deriv (fun t : ℝ => logPartition beta (scorePerturb s i t)) 0
      = beta * scoreSoftmax beta s i :=
  (hasDerivAt_logPartition_score beta s i).deriv

/-! ## The Jacobian of Softmax -/

/-- The **Softmax Jacobian** `∂pⱼ/∂sᵢ = β·pⱼ·(δᵢⱼ − pᵢ)`. -/
def softmaxJacobian (beta : ℝ) (s : Fin m → ℝ) (i j : Fin m) : ℝ :=
  beta * scoreSoftmax beta s j * ((if j = i then (1 : ℝ) else 0) - scoreSoftmax beta s i)

/-- **The Jacobian of Softmax in the scores.**  Raising the score of key `i`
raises `pⱼ` at rate `β·pⱼ(δᵢⱼ − pᵢ)`. -/
theorem hasDerivAt_scoreSoftmax_score (beta : ℝ) (s : Fin m → ℝ) (i j : Fin m) :
    HasDerivAt (fun t : ℝ => scoreSoftmax beta (scorePerturb s i t) j)
      (softmaxJacobian beta s i j) 0 := by
  have hne := partition_ne_zero beta s i
  have hZ := hasDerivAt_partition_score beta s i
  have hnum : HasDerivAt (fun t : ℝ => Real.exp (beta * scorePerturb s i t j))
      ((if j = i then beta else 0) * Real.exp (beta * s j)) 0 := by
    by_cases hj : j = i
    · subst hj
      simpa [scorePerturb] using hasDerivAt_exp_score beta 0 (s j)
    · simpa [scorePerturb, hj] using (hasDerivAt_const (0 : ℝ) (Real.exp (beta * s j)))
  have h := hnum.div hZ (by simpa using hne)
  have hgoal : (fun t : ℝ => scoreSoftmax beta (scorePerturb s i t) j)
      = fun t : ℝ =>
        Real.exp (beta * scorePerturb s i t j) / partition beta (scorePerturb s i t) := by
    funext t
    rw [scoreSoftmax_eq_div]
  rw [hgoal]
  refine h.congr_deriv ?_
  have hP : (0 : ℝ) < partition beta s := partition_pos beta s i
  rw [softmaxJacobian, scoreSoftmax_eq_div, scoreSoftmax_eq_div]
  simp only [scorePerturb_zero]
  rcases eq_or_ne j i with hj | hj
  · subst hj
    rw [if_pos (rfl : j = j), if_pos (rfl : j = j)]
    field_simp
  · rw [if_neg hj, if_neg hj]
    field_simp
    ring

theorem deriv_scoreSoftmax_score (beta : ℝ) (s : Fin m → ℝ) (i j : Fin m) :
    deriv (fun t : ℝ => scoreSoftmax beta (scorePerturb s i t) j) 0
      = softmaxJacobian beta s i j :=
  (hasDerivAt_scoreSoftmax_score beta s i j).deriv

/-! ## Structure of the Jacobian -/

/-- **The Jacobian is symmetric** — as the Hessian of the free energy `log Z` in
the scores must be. -/
theorem softmaxJacobian_symm (beta : ℝ) (s : Fin m → ℝ) (i j : Fin m) :
    softmaxJacobian beta s i j = softmaxJacobian beta s j i := by
  by_cases h : j = i
  · subst h; rfl
  · simp only [softmaxJacobian, h, Ne.symm h, if_false]
    ring

/-- **Attention is conserved.**  The weights sum to one at every score profile, so
nudging one score redistributes weight without creating any: each row of the
Jacobian sums to zero. -/
theorem softmaxJacobian_row_sum_zero (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    ∑ j, softmaxJacobian beta s i j = 0 := by
  have hsum : ∑ j, scoreSoftmax beta s j = 1 := scoreSoftmax_sum_one beta s i
  have hterm : ∀ j : Fin m, softmaxJacobian beta s i j
      = (if j = i then beta * scoreSoftmax beta s j else 0)
        - beta * scoreSoftmax beta s i * scoreSoftmax beta s j := by
    intro j
    rcases eq_or_ne j i with hj | hj
    · subst hj
      rw [softmaxJacobian, if_pos (rfl : j = j), if_pos (rfl : j = j)]
      ring
    · rw [softmaxJacobian, if_neg hj, if_neg hj]
      ring
  have hpick : ∑ j, (if j = i then beta * scoreSoftmax beta s j else 0)
      = beta * scoreSoftmax beta s i :=
    by simp
  rw [Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_sub_distrib, hpick,
    ← Finset.mul_sum, hsum]
  ring

/-- Raising a key's own score never hurts it (at `β ≥ 0`). -/
theorem softmaxJacobian_diag_nonneg {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ) (i : Fin m) :
    0 ≤ softmaxJacobian beta s i i := by
  have h1 : scoreSoftmax beta s i ≤ 1 := scoreSoftmax_le_one beta s i
  have h2 : 0 ≤ scoreSoftmax beta s i := le_of_lt (scoreSoftmax_pos beta s i)
  have : 0 ≤ (1 : ℝ) - scoreSoftmax beta s i := by linarith
  simpa [softmaxJacobian] using mul_nonneg (mul_nonneg hb h2) this

/-- Raising one key's score can only take weight away from the others
(at `β ≥ 0`). -/
theorem softmaxJacobian_offDiag_nonpos {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    {i j : Fin m} (hij : j ≠ i) : softmaxJacobian beta s i j ≤ 0 := by
  have h2 : 0 ≤ scoreSoftmax beta s i := le_of_lt (scoreSoftmax_pos beta s i)
  have h3 : 0 ≤ scoreSoftmax beta s j := le_of_lt (scoreSoftmax_pos beta s j)
  have : softmaxJacobian beta s i j
      = -(beta * scoreSoftmax beta s j * scoreSoftmax beta s i) := by
    simp only [softmaxJacobian, hij, if_false]
    ring
  rw [this, neg_nonpos]
  exact mul_nonneg (mul_nonneg hb h3) h2

/-! ## The quadratic form: the Jacobian is a covariance -/

/-- The attention-weighted variance of an arbitrary test vector `x`. -/
def weightedVar (beta : ℝ) (s x : Fin m → ℝ) : ℝ :=
  (∑ j, scoreSoftmax beta s j * x j ^ 2) - (∑ j, scoreSoftmax beta s j * x j) ^ 2

theorem weightedVar_eq_sum_sq (beta : ℝ) (s x : Fin m → ℝ) (i : Fin m) :
    weightedVar beta s x
      = ∑ j, scoreSoftmax beta s j * (x j - ∑ l, scoreSoftmax beta s l * x l) ^ 2 := by
  have hsum : ∑ j, scoreSoftmax beta s j = 1 := scoreSoftmax_sum_one beta s i
  set mu := ∑ l, scoreSoftmax beta s l * x l with hmu
  have hexp : ∀ j : Fin m, scoreSoftmax beta s j * (x j - mu) ^ 2
      = scoreSoftmax beta s j * x j ^ 2 - 2 * mu * (scoreSoftmax beta s j * x j)
        + mu ^ 2 * scoreSoftmax beta s j := fun j => by ring
  rw [weightedVar, Finset.sum_congr rfl fun j _ => hexp j, Finset.sum_add_distrib,
    Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.mul_sum, hsum, ← hmu]
  ring

theorem weightedVar_nonneg (beta : ℝ) (s x : Fin m → ℝ) (i : Fin m) :
    0 ≤ weightedVar beta s x := by
  rw [weightedVar_eq_sum_sq beta s x i]
  exact Finset.sum_nonneg fun j _ =>
    mul_nonneg (le_of_lt (scoreSoftmax_pos beta s j)) (sq_nonneg _)

/-- **The quadratic form of the Softmax Jacobian is `β` times a variance.** -/
theorem softmaxJacobian_quadratic_form (beta : ℝ) (s x : Fin m → ℝ) :
    ∑ i, ∑ j, x i * softmaxJacobian beta s i j * x j = beta * weightedVar beta s x := by
  have key : ∀ i : Fin m, ∑ j, x i * softmaxJacobian beta s i j * x j
      = beta * (scoreSoftmax beta s i * x i ^ 2)
        - beta * (scoreSoftmax beta s i * x i) * ∑ j, scoreSoftmax beta s j * x j := by
    intro i
    have hterm : ∀ j : Fin m, x i * softmaxJacobian beta s i j * x j
        = (if j = i then beta * (scoreSoftmax beta s j * x j * x i) else 0)
          - beta * (scoreSoftmax beta s i * x i) * (scoreSoftmax beta s j * x j) := by
      intro j
      rcases eq_or_ne j i with hj | hj
      · subst hj
        rw [softmaxJacobian, if_pos (rfl : j = j), if_pos (rfl : j = j)]
        ring
      · rw [softmaxJacobian, if_neg hj, if_neg hj]
        ring
    have hpick : ∑ j, (if j = i then beta * (scoreSoftmax beta s j * x j * x i) else 0)
        = beta * (scoreSoftmax beta s i * x i ^ 2) := by
      simp only [Finset.sum_ite_eq', Finset.mem_univ, ↓reduceIte]
      ring
    rw [Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_sub_distrib, hpick,
      ← Finset.mul_sum]
  have expand : ∑ i, ∑ j, x i * softmaxJacobian beta s i j * x j
      = (∑ i, beta * (scoreSoftmax beta s i * x i ^ 2))
        - ∑ i, beta * (scoreSoftmax beta s i * x i) * ∑ j, scoreSoftmax beta s j * x j := by
    rw [Finset.sum_congr rfl fun i _ => key i, Finset.sum_sub_distrib]
  rw [expand, ← Finset.sum_mul, ← Finset.mul_sum, ← Finset.mul_sum, weightedVar]
  ring

/-- **The Softmax Jacobian is positive semidefinite at `β ≥ 0`** (equivalently:
the free energy is convex in the scores). -/
theorem softmaxJacobian_posSemidef {beta : ℝ} (hb : 0 ≤ beta) (s x : Fin m → ℝ) (i : Fin m) :
    0 ≤ ∑ i, ∑ j, x i * softmaxJacobian beta s i j * x j := by
  rw [softmaxJacobian_quadratic_form]
  exact mul_nonneg hb (weightedVar_nonneg beta s x i)

/-- Evaluated on the scores themselves the quadratic form returns `β·Var_β(s)`,
the fluctuation of `ChapterSoftmaxFluctuation`. -/
theorem softmaxJacobian_quadratic_form_score (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    ∑ a, ∑ b, s a * softmaxJacobian beta s a b * s b = beta * varScore beta s := by
  rw [softmaxJacobian_quadratic_form]
  simp only [weightedVar, varScore_eq_sub_sq beta s i, meanScore]

end BookProof.ChapterSoftmaxJacobian

end
