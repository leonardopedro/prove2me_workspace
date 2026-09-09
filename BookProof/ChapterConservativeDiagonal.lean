import Mathlib
import BookProof.ChapterFreeFieldConstraint

/-!
# Chapter "Wave-function parametrization of a probability measure", §8 —
# the conservative double-commutator condition `[[H, P_A], P_B] = 0`

Source: `book.tex`, section *"8. Conservative transformations"* (line ~1917).

The book calls a Hamiltonian `H` **conservative** when the double commutator
`[[H, P_A], P_B] = 0` vanishes for all events `A, B ⊆ X`, where `P_A` is the
projection-valued measure of the (commutative) event algebra.  The complementary
unitary-time-evolution content of that section is in `BookProof.ChapterConservative`;
this file formalizes the algebraic **conservative condition itself**, in the
finite-dimensional model where events are subsets `S ⊆ {1, …, n}` and `P_S` is the
diagonal projection `diag(𝟙_S)` in the measurement basis.

Main results (with `⁅·,·⁆` the matrix commutator
`BookProof.FreeFieldConstraint.bracket`):

* `eventProj` — the diagonal event projection `P_S = diag(𝟙_S)`, with
  `eventProj_isDiag`, `eventProj_idem` (`P_S² = P_S`) and `eventProj_commute`
  (event projections pairwise commute, i.e. the event algebra is commutative);
* `commutes_all_events_iff_isDiag` — `H` commutes with **every** event projection
  iff `H` is diagonal;
* `conservative_iff_isDiag` — **the headline**: the conservative double-commutator
  condition `∀ S T, ⁅⁅H, P_S⁆, P_T⁆ = 0` holds iff `H` is diagonal.

Thus in finite dimensions the conservative condition is exactly as strong as full
commutation with the event algebra (`H` diagonal): the *only* conservative
Hamiltonians are the classical/diagonal ones.  This is the finite-dimensional
counterpart of the book's remark, and pinpoints why the book's genuinely
non-diagonal conservative Hamiltonians (`H = Σ_j p_j⁅H,x_j⁆ + ⁅H,x_j⁆p_j`,
built from momentum operators) require a *continuous* spectrum: there `⁅H, P_A⁆`
becomes a multiplication (diagonal) operator supported on the boundary `∂A`, which
then commutes with every `P_B`, an escape that has no finite-dimensional analogue.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped Matrix
open Matrix BookProof.FreeFieldConstraint

namespace BookProof.ConservativeDiagonal

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- The diagonal **event projection** `P_S = diag(𝟙_S)` onto the coordinates of an
event (subset) `S ⊆ {1, …, n}`, in the measurement basis. -/
noncomputable def eventProj (S : Finset n) : Matrix n n ℂ :=
  Matrix.diagonal (fun k => if k ∈ S then (1 : ℂ) else 0)

omit [Fintype n] in
@[simp] theorem eventProj_apply (S : Finset n) (k l : n) :
    eventProj S k l = if k = l then (if k ∈ S then (1 : ℂ) else 0) else 0 := by
  simp [eventProj, Matrix.diagonal_apply]

omit [Fintype n] in
/-- Event projections are diagonal. -/
theorem eventProj_isDiag (S : Finset n) : (eventProj S).IsDiag := by
  intro k l hkl; simp [eventProj_apply, hkl]

/-- Event projections are idempotent: `P_S² = P_S`. -/
theorem eventProj_idem (S : Finset n) : eventProj S * eventProj S = eventProj S := by
  unfold eventProj
  rw [Matrix.diagonal_mul_diagonal]
  congr 1; funext k; by_cases h : k ∈ S <;> simp [h]

/-- Event projections pairwise commute — the event algebra is commutative. -/
theorem eventProj_commute (S T : Finset n) :
    eventProj S * eventProj T = eventProj T * eventProj S := by
  unfold eventProj
  rw [Matrix.diagonal_mul_diagonal, Matrix.diagonal_mul_diagonal]
  congr 1; funext k; ring

/-- Entrywise form of a single commutator with an event projection:
`⁅H, P_S⁆ k l = H k l · (𝟙_S l − 𝟙_S k)`. -/
theorem bracket_eventProj_apply (H : Matrix n n ℂ) (S : Finset n) (k l : n) :
    bracket H (eventProj S) k l
      = H k l * ((if l ∈ S then (1 : ℂ) else 0) - (if k ∈ S then (1 : ℂ) else 0)) := by
  simp only [bracket, eventProj, Matrix.sub_apply, Matrix.mul_diagonal, Matrix.diagonal_mul]
  ring

/-- `H` commutes with **every** event projection iff `H` is diagonal. -/
theorem commutes_all_events_iff_isDiag (H : Matrix n n ℂ) :
    (∀ S : Finset n, bracket H (eventProj S) = 0) ↔ H.IsDiag := by
  constructor
  · intro h k l hkl
    have := congrFun (congrFun (h {l}) k) l
    rw [bracket_eventProj_apply] at this
    simp only [Matrix.zero_apply, Finset.mem_singleton] at this
    have hkl' : ¬ (k = l) := hkl
    simp only [hkl', if_true, if_false] at this
    simpa using this
  · intro hdiag S
    ext k l
    rw [bracket_eventProj_apply]
    by_cases hkl : k = l
    · subst hkl; simp
    · rw [hdiag hkl]; simp

/-- **The conservative condition.** The double-commutator conservative condition
`∀ events S T, ⁅⁅H, P_S⁆, P_T⁆ = 0` holds iff `H` is diagonal. -/
theorem conservative_iff_isDiag (H : Matrix n n ℂ) :
    (∀ S T : Finset n, bracket (bracket H (eventProj S)) (eventProj T) = 0) ↔ H.IsDiag := by
  constructor
  · intro h k l hkl
    have h2 := congrFun (congrFun (h {k} {l}) k) l
    simp only [bracket_eventProj_apply, Matrix.zero_apply, Finset.mem_singleton] at h2
    have hlk : ¬ (l = k) := fun e => hkl e.symm
    have hkl' : ¬ (k = l) := hkl
    simp only [hkl', hlk, if_true, if_false] at h2
    simpa using h2
  · intro hdiag S T
    ext k l
    simp only [bracket_eventProj_apply, Matrix.zero_apply]
    by_cases hkl : k = l
    · subst hkl; ring
    · rw [hdiag hkl]; ring

end BookProof.ConservativeDiagonal
