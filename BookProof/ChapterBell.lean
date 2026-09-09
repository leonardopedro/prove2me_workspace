import Mathlib

/-!
# Chapter "Reconstructing the classical trajectory of any isolated quantum system",
  §"Do the Bell inequalities hold?"

This file formalizes the self-contained mathematical content flagged in the `book.tex`
section *"Do the Bell inequalities hold?"* (`book.tex` line ~3175).  The chapter's own
concession is that *"the Bell inequalities (despite being mathematically valid inequalities)
involve unrealistic assumptions"* — so the two mathematically formalizable facts are:

1. **The Bell / CHSH inequality is a valid inequality for any local hidden-variable model.**
   If a "standard statistical theory" is described by a probability distribution on a
   phase space and the four dichotomic (`±1`-valued, or more generally `[-1,1]`-valued)
   measurement outcomes `A₀, A₁` (Alice) and `B₀, B₁` (Bob) are ordinary random variables
   on that space, then the CHSH correlator obeys
   `|⟨A₀B₀⟩ + ⟨A₀B₁⟩ + ⟨A₁B₀⟩ − ⟨A₁B₁⟩| ≤ 2`.

2. **Quantum mechanics violates it.**  With Alice's observables `σ_z, σ_x`, Bob's
   observables `(σ_z ± σ_x)/√2`, and the maximally entangled Bell state
   `|Φ⁺⟩ = (|00⟩ + |11⟩)/√2`, the same CHSH combination of expectation values equals
   `2√2 > 2` (the Tsirelson value).  This is exactly why the classical bound is
   *"innocuous"* as a distinguishing criterion: a complete statistical theory (quantum
   mechanics) sits outside the local hidden-variable class the inequality characterizes.

## Contents

* `chsh_pointwise` — the elementary pointwise algebraic inequality: for
  `a₀,a₁,b₀,b₁ ∈ [-1,1]`, `|a₀b₀ + a₀b₁ + a₁b₀ − a₁b₁| ≤ 2`.
* `chsh_local` — the measure-theoretic Bell/CHSH inequality: for any probability measure
  `μ` and `[-1,1]`-valued random variables, the CHSH correlator is `≤ 2` in absolute value.
* `chsh_quantum_value` — the quantum expectation value of the CHSH operator in the Bell
  state `|Φ⁺⟩` equals `2√2`.
* `chsh_quantum_violates_local_bound` — `2 < 2√2`: quantum mechanics exceeds the classical
  Bell bound.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped BigOperators
open MeasureTheory

namespace BookProof.ChapterBell

/-! ## Part A — the classical Bell / CHSH inequality (local hidden variables) -/

/-- **The pointwise CHSH inequality.**  For any four reals in `[-1,1]`, the CHSH
combination is bounded in absolute value by `2`.  This is the deterministic
(hidden-variable) core: `a₀(b₀+b₁) + a₁(b₀−b₁)` has absolute value at most
`|b₀+b₁| + |b₀−b₁| = 2·max(|b₀|,|b₁|) ≤ 2`. -/
theorem chsh_pointwise {a₀ a₁ b₀ b₁ : ℝ}
    (ha₀ : |a₀| ≤ 1) (ha₁ : |a₁| ≤ 1) (hb₀ : |b₀| ≤ 1) (hb₁ : |b₁| ≤ 1) :
    |a₀ * b₀ + a₀ * b₁ + a₁ * b₀ - a₁ * b₁| ≤ 2 := by
  rw [abs_le] at *
  constructor <;> cases abs_cases (a₀ + a₁) <;> cases abs_cases (b₀ + b₁) <;>
    nlinarith [mul_nonneg (sub_nonneg.2 ha₀.1) (sub_nonneg.2 hb₀.1),
      mul_nonneg (sub_nonneg.2 ha₀.2) (sub_nonneg.2 hb₀.2),
      mul_nonneg (sub_nonneg.2 ha₁.1) (sub_nonneg.2 hb₁.1),
      mul_nonneg (sub_nonneg.2 ha₁.2) (sub_nonneg.2 hb₁.2)]

variable {Ω : Type*} [MeasurableSpace Ω]

/-- **The Bell / CHSH inequality for a local hidden-variable model.**  Given a probability
space `(Ω, μ)` and four dichotomic observables valued in `[-1,1]` (Alice's `A₀, A₁` and
Bob's `B₀, B₁`, all functions of the same hidden variable `ω`), the CHSH correlator built
from the expectation values is bounded by `2` in absolute value. -/
theorem chsh_local
    (μ : Measure Ω) [IsProbabilityMeasure μ]
    (A₀ A₁ B₀ B₁ : Ω → ℝ)
    (bA₀ : ∀ ω, |A₀ ω| ≤ 1) (bA₁ : ∀ ω, |A₁ ω| ≤ 1)
    (bB₀ : ∀ ω, |B₀ ω| ≤ 1) (bB₁ : ∀ ω, |B₁ ω| ≤ 1) :
    |∫ ω, (A₀ ω * B₀ ω + A₀ ω * B₁ ω + A₁ ω * B₀ ω - A₁ ω * B₁ ω) ∂μ| ≤ 2 := by
  refine le_trans (MeasureTheory.norm_integral_le_integral_norm (_ : Ω → ℝ))
    (le_trans (MeasureTheory.integral_mono_of_nonneg
      (Filter.Eventually.of_forall fun ω => norm_nonneg _) (by norm_num)
      (Filter.Eventually.of_forall fun ω =>
        chsh_pointwise (bA₀ ω) (bA₁ ω) (bB₀ ω) (bB₁ ω))) (by norm_num))

/-! ## Part B — the quantum violation (Tsirelson value `2√2`) -/

open Matrix
open scoped Kronecker ComplexConjugate

/-- Pauli `σ_x`. -/
def sx : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; 1, 0]

/-- Pauli `σ_z`. -/
def sz : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, -1]

/-- Alice's first observable `A₀ = σ_z`. -/
def A0 : Matrix (Fin 2) (Fin 2) ℂ := sz

/-- Alice's second observable `A₁ = σ_x`. -/
def A1 : Matrix (Fin 2) (Fin 2) ℂ := sx

/-- Bob's first observable `B₀ = (σ_z + σ_x)/√2`. -/
noncomputable def B0 : Matrix (Fin 2) (Fin 2) ℂ := (1 / (Real.sqrt 2 : ℂ)) • (sz + sx)

/-- Bob's second observable `B₁ = (σ_z − σ_x)/√2`. -/
noncomputable def B1 : Matrix (Fin 2) (Fin 2) ℂ := (1 / (Real.sqrt 2 : ℂ)) • (sz - sx)

/-- The CHSH operator `A₀⊗B₀ + A₀⊗B₁ + A₁⊗B₀ − A₁⊗B₁` on the two-qubit space. -/
noncomputable def chshOp : Matrix (Fin 2 × Fin 2) (Fin 2 × Fin 2) ℂ :=
  A0 ⊗ₖ B0 + A0 ⊗ₖ B1 + A1 ⊗ₖ B0 - A1 ⊗ₖ B1

/-- The maximally entangled Bell state `|Φ⁺⟩ = (|00⟩ + |11⟩)/√2`. -/
noncomputable def bellState : (Fin 2 × Fin 2) → ℂ :=
  fun p => if p = (0, 0) then (1 / (Real.sqrt 2 : ℂ))
           else if p = (1, 1) then (1 / (Real.sqrt 2 : ℂ)) else 0

/-- The CHSH expectation value `⟨Φ⁺| S |Φ⁺⟩`. -/
noncomputable def chshValue : ℂ := (star bellState) ⬝ᵥ (chshOp *ᵥ bellState)

/-- **The quantum CHSH value is the Tsirelson value `2√2`.**  Direct computation of the
two-qubit expectation value `⟨Φ⁺| S |Φ⁺⟩` in the Bell state.  The four correlators are
`⟨A₀⊗B₀⟩ = ⟨A₀⊗B₁⟩ = ⟨A₁⊗B₀⟩ = 1/√2` and `⟨A₁⊗B₁⟩ = −1/√2`, so the CHSH combination is
`4/√2 = 2√2`. -/
theorem chsh_quantum_value : chshValue = ((2 * Real.sqrt 2 : ℝ) : ℂ) := by
  have hne : (Real.sqrt 2 : ℂ) ≠ 0 := by simp
  have h2 : (Real.sqrt 2 : ℂ) ^ 2 = 2 := by norm_cast; exact Real.sq_sqrt (by norm_num)
  unfold chshValue chshOp bellState A0 A1 B0 B1 sx sz
  simp [Matrix.mulVec, dotProduct, Fintype.sum_prod_type, Fin.sum_univ_two,
    Matrix.add_apply, Matrix.sub_apply, mul_comm]
  field_simp
  linear_combination (-2 * (Real.sqrt 2 : ℂ) ^ 2 - 4) * h2

/-- **Quantum mechanics violates the classical Bell bound**: `2 < 2√2`. -/
theorem chsh_quantum_violates_local_bound : (2 : ℝ) < 2 * Real.sqrt 2 := by
  nlinarith [Real.sqrt_nonneg 2, Real.sq_sqrt zero_le_two]

end BookProof.ChapterBell
