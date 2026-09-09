import Mathlib
import BookProof.ChapterTrajectory

/-!
# Chapter "Reconstructing the classical trajectory of any isolated quantum system"
— §"Weak measurements and weak values"

Source: `book.tex`, chapter *"Reconstructing the classical trajectory of any
isolated quantum system"*, §*"Reconstruction of the trajectory"*, and the
double-slit chapter's "Weak Measurements" section (`Book/DoubleSlit.lean`).

`BookProof.ChapterTrajectory` formalizes the post-selected (ABL / two-state)
*probability* of an intermediate outcome.  This module formalizes the companion
object: the **weak value** of an observable `A` for a pre-selection `|i⟩` and a
post-selection `|f⟩`,

  `⟨A⟩_w = ⟨f|A|i⟩ / ⟨f|i⟩`,

on the finite complex Hilbert space `Fin n → ℂ` with the standard inner product
`ip f v = ∑ₖ conj (f k) * v k`.

Main results:

* `weakValue_wellDefined` — whenever `⟨f|i⟩ ≠ 0` the ratio is the unique solution
  of `⟨A⟩_w · ⟨f|i⟩ = ⟨f|A|i⟩` (so it is a well-defined complex number);
* `weakValue_diag` — when the post-selection *is* the pre-selection (`f = i`, a
  unit vector) the weak value collapses to the ordinary expectation `⟨i|A|i⟩`;
* `weakValue_diag_isReal` — and that expectation is real for a Hermitian `A`;
* `weakValue_add`, `weakValue_smul`, `weakValue_linear` — linearity in the
  observable, the algebraic core of "weak measurements are linear in `A`";
* `weakValue_proj`, `weakValue_proj_sum` — weak values of the basis projectors,
  which sum to `1` exactly like the post-selected probabilities of
  `ChapterTrajectory.condProb_sum`;
* `jointProb_eq_normSq_weakNumerator` and `condProb_eq_weakNumerator_ratio` — the
  tie to `ChapterTrajectory`: the ABL joint law is the squared modulus of the
  weak-value numerator for the post-selection vector `b ↦ conj (V f b)`, and the
  post-selected conditional law is the normalized version of it;
* `dslit_weakValue` — the double-slit capstone: pre-selecting the both-slits
  superposition `H·Ψ` and post-selecting the state `Ψ = (1,0)`, the which-slit
  projectors have weak values `1` and `0`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped BigOperators Matrix

namespace BookProof.ChapterWeakValue

variable {n : ℕ}

/-- The standard inner product on `Fin n → ℂ`, conjugate-linear in the first
argument: `⟨f|v⟩ = ∑ₖ conj (f k) · v k`. -/
noncomputable def ip (f v : Fin n → ℂ) : ℂ := ∑ k, starRingEnd ℂ (f k) * v k

/-- The **weak value** of the observable `A` for the pre-selection `i` and the
post-selection `f`: `⟨A⟩_w = ⟨f|A|i⟩ / ⟨f|i⟩`. -/
noncomputable def weakValue (i f : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ) : ℂ :=
  ip f (A *ᵥ i) / ip f i

/-! ## Elementary properties of the inner product -/

theorem ip_add_right (f v w : Fin n → ℂ) : ip f (v + w) = ip f v + ip f w := by
  simp [ip, mul_add, Finset.sum_add_distrib]

theorem ip_smul_right (c : ℂ) (f v : Fin n → ℂ) : ip f (c • v) = c * ip f v := by
  simp only [ip, Pi.smul_apply, smul_eq_mul, Finset.mul_sum]
  exact Finset.sum_congr rfl fun _ _ => by ring

/-- Moving a matrix across the inner product conjugates the pairing:
`conj ⟨f|A v⟩ = ⟨v|Aᴴ f⟩`. -/
theorem ip_conj_mulVec (A : Matrix (Fin n) (Fin n) ℂ) (f v : Fin n → ℂ) :
    starRingEnd ℂ (ip f (A *ᵥ v)) = ip v (Aᴴ *ᵥ f) := by
  simp only [ip, Matrix.mulVec, dotProduct, map_sum, map_mul, Complex.conj_conj,
    Matrix.conjTranspose_apply, RCLike.star_def, Finset.mul_sum]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring

/-! ## Well-definedness -/

/-- **Well-definedness of the weak value.**  If the pre- and post-selected states
are not orthogonal, the weak value is the unique complex number `w` with
`w · ⟨f|i⟩ = ⟨f|A|i⟩`. -/
theorem weakValue_wellDefined (i f : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (h : ip f i ≠ 0) : weakValue i f A * ip f i = ip f (A *ᵥ i) :=
  div_mul_cancel₀ _ h

/-- Uniqueness half: any `w` satisfying the defining equation *is* the weak
value. -/
theorem weakValue_unique (i f : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (h : ip f i ≠ 0) (w : ℂ) (hw : w * ip f i = ip f (A *ᵥ i)) :
    w = weakValue i f A := by
  rw [weakValue, eq_div_iff h, hw]

/-! ## Diagonal collapse to the ordinary expectation -/

/-- **Diagonal collapse.**  When the post-selection is the pre-selection and the
state is normalized, the weak value is the ordinary expectation `⟨i|A|i⟩`. -/
theorem weakValue_diag (i : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (hi : ip i i = 1) : weakValue i i A = ip i (A *ᵥ i) := by
  rw [weakValue, hi, div_one]

/-- The ordinary expectation of a Hermitian observable is real, so the diagonal
weak value is real. -/
theorem weakValue_diag_isReal (i : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (hA : Aᴴ = A) (hi : ip i i = 1) :
    starRingEnd ℂ (weakValue i i A) = weakValue i i A := by
  rw [weakValue_diag i A hi, ip_conj_mulVec, hA]

/-! ## Linearity in the observable -/

theorem weakValue_add (i f : Fin n → ℂ) (A B : Matrix (Fin n) (Fin n) ℂ) :
    weakValue i f (A + B) = weakValue i f A + weakValue i f B := by
  rw [weakValue, weakValue, weakValue, Matrix.add_mulVec, ip_add_right, add_div]

theorem weakValue_smul (c : ℂ) (i f : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ) :
    weakValue i f (c • A) = c * weakValue i f A := by
  rw [weakValue, weakValue, Matrix.smul_mulVec, ip_smul_right, mul_div_assoc]

/-- **Linearity of the weak value in the observable.** -/
theorem weakValue_linear (c d : ℂ) (i f : Fin n → ℂ)
    (A B : Matrix (Fin n) (Fin n) ℂ) :
    weakValue i f (c • A + d • B) =
      c * weakValue i f A + d * weakValue i f B := by
  rw [weakValue_add, weakValue_smul, weakValue_smul]

/-- The weak value of the identity is `1` for any non-orthogonal pre/post pair. -/
theorem weakValue_one (i f : Fin n → ℂ) (h : ip f i ≠ 0) :
    weakValue i f (1 : Matrix (Fin n) (Fin n) ℂ) = 1 := by
  rw [weakValue, Matrix.one_mulVec, div_self h]

/-! ## Weak values of the basis projectors -/

/-- The rank-one projector onto the `a`-th basis vector. -/
def projMat (a : Fin n) : Matrix (Fin n) (Fin n) ℂ :=
  fun b c => if b = a ∧ c = a then 1 else 0

theorem projMat_mulVec (a : Fin n) (v : Fin n → ℂ) (b : Fin n) :
    (projMat a *ᵥ v) b = if b = a then v a else 0 := by
  by_cases hb : b = a <;>
    simp [projMat, Matrix.mulVec, dotProduct, hb, Finset.sum_ite_eq']

theorem ip_projMat (a : Fin n) (f v : Fin n → ℂ) :
    ip f (projMat a *ᵥ v) = starRingEnd ℂ (f a) * v a := by
  simp [ip, projMat_mulVec, Finset.sum_ite_eq']

/-- The weak value of the `a`-th basis projector is
`conj (f a) · i a / ⟨f|i⟩` — the amplitude analogue of the ABL probability. -/
theorem weakValue_proj (i f : Fin n → ℂ) (a : Fin n) :
    weakValue i f (projMat a) = starRingEnd ℂ (f a) * i a / ip f i := by
  rw [weakValue, ip_projMat]

/-- **The weak values of a complete family of projectors sum to `1`** — the
weak-value counterpart of `ChapterTrajectory.condProb_sum`. -/
theorem weakValue_proj_sum (i f : Fin n → ℂ) (h : ip f i ≠ 0) :
    ∑ a, weakValue i f (projMat a) = 1 := by
  simp only [weakValue_proj, ← Finset.sum_div]
  rw [show ∑ a, starRingEnd ℂ (f a) * i a = ip f i from rfl, div_self h]

/-! ## Tie to the post-selected (ABL) probabilities of `ChapterTrajectory` -/

open BookProof.ChapterTrajectory in
/-- The post-selection covector attached to the final outcome `f` of the unitary
`V`: `b ↦ conj (V f b)`, i.e. the state whose overlap with the intermediate
basis vector `e_b` is the transition amplitude `V_{f b}`. -/
def postSelect (V : Matrix (Fin n) (Fin n) ℂ) (f : Fin n) : Fin n → ℂ :=
  fun b => starRingEnd ℂ (V f b)

open BookProof.ChapterTrajectory in
/-- **The ABL joint law is the squared modulus of the weak-value numerator.**
With pre-selection `i = U Ψ` and post-selection `postSelect V f`, the numerator
`⟨f|P_a|i⟩` of the weak value of the projector `P_a` has squared modulus exactly
`jointProb U V Ψ f a`. -/
theorem jointProb_eq_normSq_weakNumerator (U V : Matrix (Fin n) (Fin n) ℂ)
    (psi : Fin n → ℂ) (f a : Fin n) :
    ‖ip (postSelect V f) (projMat a *ᵥ (U *ᵥ psi))‖ ^ 2 = jointProb U V psi f a := by
  rw [ip_projMat, jointProb, midProb, transProb]
  simp [postSelect, mul_pow]
  ring

open BookProof.ChapterTrajectory in
/-- **The post-selected conditional law is the normalized weak-value numerator.**
`condProb` is the squared weak-value numerator divided by the sum of the squared
weak-value numerators. -/
theorem condProb_eq_weakNumerator_ratio (U V : Matrix (Fin n) (Fin n) ℂ)
    (psi : Fin n → ℂ) (f a : Fin n) :
    condProb U V psi f a =
      ‖ip (postSelect V f) (projMat a *ᵥ (U *ᵥ psi))‖ ^ 2 /
        ∑ b, ‖ip (postSelect V f) (projMat b *ᵥ (U *ᵥ psi))‖ ^ 2 := by
  rw [condProb, finalProb, jointProb_eq_normSq_weakNumerator]
  exact congrArg _
    (Finset.sum_congr rfl fun b _ =>
      (jointProb_eq_normSq_weakNumerator U V psi f b).symm)

/-! ## Double-slit capstone -/

open BookProof.ChapterDoubleSlit

/-- The both-slits superposition `H·Ψ = (1/√2)(1,1)` — the pre-selected state. -/
theorem hadamard_psi0 : (H *ᵥ psi0) = ![(1 / Real.sqrt 2 : ℂ), (1 / Real.sqrt 2 : ℂ)] := by
  funext b
  fin_cases b <;>
    simp [H, psi0, Matrix.mulVec, dotProduct, Fin.sum_univ_two]

private theorem sqrt2_ne_zero : ((1 : ℂ) / (Real.sqrt 2 : ℂ)) ≠ 0 := by
  have h : (Real.sqrt 2 : ℝ) ≠ 0 := by positivity
  simp [Complex.ofReal_ne_zero.mpr h]

/-- The pre- and post-selected states are not orthogonal:
`⟨Ψ | H Ψ⟩ = 1/√2 ≠ 0`. -/
theorem dslit_ip_ne_zero : ip psi0 (H *ᵥ psi0) ≠ 0 := by
  have : ip psi0 (H *ᵥ psi0) = (1 / Real.sqrt 2 : ℂ) := by
    rw [hadamard_psi0]
    simp [ip, psi0, Fin.sum_univ_two]
  rw [this]
  exact sqrt2_ne_zero

/-- **Double-slit capstone.**  Pre-selecting the both-slits superposition `H·Ψ`
and post-selecting the definite state `Ψ = (1,0)`, the which-slit projectors have
weak values `1` and `0`: the post-selection assigns the whole weak "presence" to
the first slit, and (by `weakValue_proj_sum`) the two weak values sum to `1`. -/
theorem dslit_weakValue :
    weakValue (H *ᵥ psi0) psi0 (projMat 0) = 1 ∧
      weakValue (H *ᵥ psi0) psi0 (projMat 1) = 0 := by
  have hip : ip psi0 (H *ᵥ psi0) = (1 / Real.sqrt 2 : ℂ) := by
    rw [hadamard_psi0]; simp [ip, psi0, Fin.sum_univ_two]
  constructor
  · rw [weakValue_proj, hip, hadamard_psi0]
    simp [psi0]
  · rw [weakValue_proj, hip, hadamard_psi0]
    simp [psi0]

end BookProof.ChapterWeakValue
