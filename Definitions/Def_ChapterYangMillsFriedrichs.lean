import Mathlib

/-!
# Quantum Yang–Mills: the Weyl-gauge form and its closability (the Friedrichs route)

Source: `book.tex`, chapter *"Quantization due to time-evolution: Yang-Mills and
Classical Statistical Field Theory"*, §*"Pure SU(3) Yang-Mills theory"*
(~7037–7120), and the plan item recorded in `CONSOLIDATED_PLAN.md` §11 (Parts
A–D of the suggested `PLAN_LEAN_SPECIALIST_QYM_FLOW.md`).

In the Weyl gauge and in the Hermite (oscillator) basis the gauge-fixed
Yang–Mills Hamiltonian is a **sum of squares** of the self-adjoint electric-field
operators `πⁱ_a` and magnetic-field operators `B_{i a}`,

  `H = ½ Σ (πⁱ_a)² + ½ Σ (B_{i a})²`,

hence symmetric and bounded below by `0`.  `BookProof.ChapterWeylHamiltonian`
proves this for *bounded* fields; the Friedrichs route needs the same statement
for a **densely defined** operator on a domain, together with the closability of
its quadratic form — that is what this module supplies.

## What is proved here (all `sorry`-free and `axiom`-free)

**Part A — the Weyl-gauge Hamiltonian on a domain.**

* `weylOpDom` — `H = ½ Σ πᵢ² + ½ Σ Bₐ²` as an operator `D →ₗ[ℂ] D`;
* `weylOpDom_symmetricOn` — it is symmetric on `D`;
* `weylOpDom_quadForm` — its quadratic form is the **sum of squares**
  `q(x) = ½ Σ ‖πᵢ x‖² + ½ Σ ‖Bₐ x‖²`;
* `weylOpDom_quadForm_nonneg` — hence `H ≥ 0`: the operator is semi-bounded, the
  hypothesis of the Friedrichs extension theorem.

**Part B — the quadratic form and its closure.**  For an arbitrary symmetric,
positive operator `H` on a domain `D`:

* `formInner`, `formNormSq` — the form inner product `⟪x,y⟫ + ⟪x, H y⟫` and the
  associated form norm;
* `formInner_conj_symm`, `formNormSq_ge_normSq` — it is a Hermitian form
  dominating the ambient norm (`‖x‖² ≤ q(x)`), so it *is* an inner product;
* `formNormSq_add`, `formNormSq_add_le`, `re_formInner_sq_le` — the expansion of
  the form norm and its **Cauchy–Schwarz inequality**;
* `form_closable` — **the headline of Part B.**  *The form is closable*: if a
  sequence is Cauchy in the form norm and tends to `0` in the ambient space, then
  its form norm tends to `0`.  This is exactly the step that makes the
  Friedrichs construction well defined (the form closure has no "ghost"
  elements), and it is where symmetry and positivity of `H` are used;
* `weylForm_closable` — the Weyl-gauge form of Part A is closable.

**Part C — the Friedrichs extension, as a named theorem (never an axiom).**

* `friedrichs_extension_of_semibounded` — the classical theorem (K. Friedrichs,
  *Spektraltheorie halbbeschränkter Operatoren*, Math. Ann. **109** (1934)
  465–487; M. Reed & B. Simon, *Methods of Modern Mathematical Physics* I/II,
  Thm X.23) enters as an explicit hypothesis and is applied to the Weyl-gauge
  operator: a densely defined symmetric positive operator has a self-adjoint
  positive extension.
* `friedrichs_hypothesis_satisfiable` — the named hypothesis is **not vacuous**:
  it holds (with the operator as its own extension) whenever the domain is the
  whole space, which is the bounded Weyl case of
  `BookProof.ChapterWeylHamiltonian`.
* `weyl_friedrichs_extension` — the conclusion for the Weyl-gauge Hamiltonian,
  conditional on that named theorem.

**Part D — the Hashimoto/SIRK limit (research conjecture, recorded not claimed).**

* `weylKrylov_bestApprox_antitone`, `weylKrylov_bestApprox_tendsto_zero` — the
  *proved* supporting facts, specialized to the Weyl-gauge generator: the Krylov
  (Hashimoto order-`n`) best-approximation error is antitone in the order and
  tends to `0` for a cyclic seed;
* the conjecture of `CONSOLIDATED_PLAN.md` §11.2 ("the infinite Hashimoto limit
  selects the Friedrichs extension") is **recorded in prose** in Part D and is
  neither stated as a Lean theorem nor proved: its formalization needs the limit
  operator of the Krylov flag, which is not constructed here.

## Scope

Nothing here claims self-adjointness of the continuum Yang–Mills operator on
`L²(ℝ⁹⁹ × ℤ₂³¹)`, nor a mass gap, nor global existence.  The Millennium problem
is out of scope; the Friedrichs theorem itself is a *hypothesis*, and the
Hashimoto-limit identification is recorded as a conjecture.
-/

namespace BookProof.YangMillsFriedrichs


/-! ## Part B (general theory) — the form of a positive symmetric operator

We develop the form first, since Part A is an instance of it. -/

section Form

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

/-- The **form inner product** of a positive symmetric operator `H`:
`⟪x, y⟫_H = ⟪x, y⟫ + ⟪x, H y⟫`.  Its completion is the form domain of the
Friedrichs extension. -/
noncomputable def formInner (H : D →ₗ[ℂ] F) (x y : D) : ℂ :=
  inner ℂ (x : F) (y : F) + inner ℂ (x : F) (H y)

/-- The **form norm** squared, `‖x‖_H² = ‖x‖² + ⟪x, H x⟫`. -/
noncomputable def formNormSq (H : D →ₗ[ℂ] F) (x : D) : ℝ := (formInner H x x).re































end Form

/-! ## Part A — the Weyl-gauge Hamiltonian on a domain -/

section Weyl

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

/-- The **Weyl-gauge Yang–Mills Hamiltonian on a domain**,
`H = ½ Σᵢ πᵢ² + ½ Σₐ Bₐ²`, for electric- and magnetic-field operators that leave
the domain invariant. -/
noncomputable def weylOpDom {n m : ℕ} (pi : Fin n → D →ₗ[ℂ] D) (Bf : Fin m → D →ₗ[ℂ] D) :
    D →ₗ[ℂ] D :=
  (((1 / 2 : ℝ) : ℂ)) • ((∑ i, (pi i).comp (pi i)) + (∑ a, (Bf a).comp (Bf a)))

/-- The Weyl-gauge Hamiltonian, viewed as an operator into the ambient space. -/
noncomputable def weylOp {n m : ℕ} (pi : Fin n → D →ₗ[ℂ] D) (Bf : Fin m → D →ₗ[ℂ] D) :
    D →ₗ[ℂ] F :=
  D.subtype.comp (weylOpDom pi Bf)













end Weyl

/-! ## Part C — the Friedrichs extension as a named theorem -/

section Friedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The statement "`A` on the domain `Dom` is a positive self-adjoint extension
of `H` on `D`", spelled out: `Dom` contains `D`, `A` agrees with `H` there, `A`
is symmetric and positive, and the adjoint of `A` is `A` itself (every vector
that behaves like a domain vector *is* one). -/
def IsPositiveSelfAdjointExtension {D Dom : Submodule ℂ F} (H : D →ₗ[ℂ] F) (A : Dom →ₗ[ℂ] F) :
    Prop :=
  (∀ x : D, ∃ h : (x : F) ∈ Dom, A ⟨(x : F), h⟩ = H x) ∧ SymmetricOn Dom A ∧
    (∀ y : Dom, 0 ≤ quadForm A y) ∧
    (∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)







end Friedrichs

/-! ## Part D — the Hashimoto/SIRK limit: proved supporting facts, and the
conjecture written down -/

section Sirk


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]





/- **The conjecture of `CONSOLIDATED_PLAN.md` §11.2 — recorded, not stated as a
Lean theorem.**  *The operator recovered in the infinite Hashimoto/SIRK limit is
the Friedrichs extension.*  Formalizing it requires the limit operator of the
Krylov flag, which is exactly the piece that is not constructed here; the two
theorems above are the proved facts that support it (nesting and, for a cyclic
seed, convergence of the best-approximation error).  It is deliberately not
written as a Lean statement, because every naive rendering of it is either
trivially true (all extensions agree on the original domain by definition) or
requires the unformalized limit. -/

end Sirk

end BookProof.YangMillsFriedrichs
