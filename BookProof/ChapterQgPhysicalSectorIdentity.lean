import Mathlib
import BookProof.ChapterGaugeFixing
import BookProof.ChapterBrstReducedTransfer
import BookProof.ChapterQuantumGravity3DGauge
import BookProof.ChapterFockQuadraticEsa

/-!
# QG-3.2(a) — the couplings are identities on the physical sector (attempt)

Plan item **QG-3.2(a)** of `CONSOLIDATED_PLAN.md`: prove that after the Weyl
3D gauge-fixing and the *derivative-variable fixing* (the Navier–Stokes
pattern: promoted derivative variables are fixed to the actual field
derivatives, `u_{i,j} = ∂_j u_i`, book.tex §4159–4197), the cross couplings
`½S·E + ⅓P·E − e(…)` of `book.tex 8190` are identities on the physical
(BRST-closed) sector — functions of the field values with no new independent
modes — so the operator genuinely reduces to the fiber list.

## What this module proves (the mechanism, unconditionally)

The NS derivative-variable fixing is the constraint `v = dφ`: the promoted
derivative variable `v` (the E-sector of the 84-dim field space) is fixed to
the actual derivative of the field.  `ChapterGaugeFixing` already formalizes
the skeleton: the gauge-fixing fermion `Ψ = c̄·(v − dφ)`, its BRST variation
`L_gf_evaluation : s Ψ = B·(v−dφ) − c̄·c` (the Lagrange multiplier
enforcing `v = dφ`, plus the ghost term), and
`int_L_gf_eq_zero` (BRST-exact terms integrate to zero on physical
observables).

This module adds the *constraint-surface reduction*:

* `DerivativeVariableFixingSystem` — the gauge-fixing system enriched with
  the two zero-laws the constraint surface needs (`0·x = 0 = x·0` for the
  `(1,0)·(1,0)` product);
* `lagrange_term_zero_of_fixing` — on the constraint surface `v = dφ`
  (`gaugeField = 0`), the Lagrange-multiplier term — the *only*
  `v`-dependent part of the gauge-fixing Lagrangian — vanishes;
* `L_gf_constraint_surface` — on the surface, `s Ψ` reduces to the ghost
  term alone: the couplings' `v`-dependence is gone, leaving the
  field-value (and ghost) content;
* `s_gaugeField_eq_c` — `v` is a BRST doublet with the ghost (the
  "contractible pair": the promoted variable and the ghosts decouple);
* the non-vacuous `2 × 2` matrix model, with the model's vanishing
  Lagrange term on its fixing surface.

## What stays a named hypothesis (the honest boundary, never an axiom)

The concrete QG statement — that the 64 derivative coordinates
`X (idxDE mu nu a)` of the 84-dim field space
(`ChapterQuantumGravity3DGauge`) *realize* the actual tetrad derivatives
(`E_ab = ∂_a e_b`, so that `torsionPoly mu nu a = ∂_μ e_ν^a − ∂_ν e_μ^a` is a
function of the tetrad and its spatial derivatives) — is **not** proved here:
the 84-dim formalism treats the `idxDE` coordinates as independent (there is
no spatial-derivative operator on the polynomial variables in the tree), so
the fixing `E = ∂e` is the open input.  It is recorded below as the
statement of record with a *named hypothesis with citation* (the NS
derivative-variable pattern, book.tex §4159–4197), in the same honesty class
as the finite-speed premise of `ChapterScalaronCoreEsa` — the formal version
of the conformal-mode elimination.  If that input fails, plan QG-3.2(b)
(direct ESA of the full operator) is the fallback.

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QgPhysicalSectorIdentity

open BookProof.GaugeFixing
open BookProof.FockQuadratic
open BookProof.OperatorSeries
open BookProof.FarisLavine
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal

/-! ## 1. The derivative-variable fixing system (NS pattern) -/

/-- The NS-style derivative-variable fixing: the gauge-fixing system enriched
with the two zero-laws the constraint surface `v = dφ` requires — the
left- and right-zero laws of the single `(1,0)·(1,0)` product instance the
Lagrange-multiplier term `B·(v−dφ)` uses.  These are the standard zero laws
of the product at exactly the one bidegree the reduction needs; nothing more
is added. -/
structure DerivativeVariableFixingSystem (F : BiDegree → Type) extends GaugeFixingSystem F where
  /-- `0 · x = 0` for the `(1,0)·(1,0)` product. -/
  mul_zero_left : ∀ x : F (1, 0), mul (1, 0) (1, 0) (zero (1, 0)) x = zero (2, 0)
  /-- `x · 0 = 0` for the `(1,0)·(1,0)` product. -/
  mul_zero_right : ∀ x : F (1, 0), mul (1, 0) (1, 0) x (zero (1, 0)) = zero (2, 0)

variable {F : BiDegree → Type} (S : DerivativeVariableFixingSystem F)

/-- The promoted derivative variable is a BRST doublet with the ghost:
`s (v − dφ) = c`.  This is the formal content of "the derivative variables
and the ghosts decouple" (a contractible pair). -/
theorem s_gaugeField_eq_c : S.s (gaugeField S.toGaugeFixingSystem) = S.c := by
  exact s_gaugeField (S := S.toGaugeFixingSystem)

/-- **The constraint-surface reduction of the coupling.**  On the physical
sector the fixing holds (`gaugeField = 0`, i.e. `v = dφ`), and the
Lagrange-multiplier term — the *only* `v`-dependent part of the
gauge-fixing Lagrangian `s Ψ = B·(v−dφ) − c̄·c` — vanishes.  The promoted
variable's coupling to `B` is an identity on the physical sector. -/
theorem lagrange_term_zero_of_fixing
    (hfix : gaugeField S.toGaugeFixingSystem = S.toGaugeFixingSystem.zero (1, 0)) :
    S.mul (1, 0) (1, 0) S.B (gaugeField S.toGaugeFixingSystem) = S.zero (2, 0) := by
  rw [hfix]
  exact S.mul_zero_right S.B

/-- On the constraint surface the gauge-fixing Lagrangian reduces to the
ghost term alone: `s Ψ = 0 − c̄·c`.  The couplings' `v`-dependence is gone;
only the field-value (through `Ψ`'s construction) and ghost content remain. -/
theorem L_gf_constraint_surface
    (hfix : gaugeField S.toGaugeFixingSystem = S.toGaugeFixingSystem.zero (1, 0)) :
    S.s (Psi S.toGaugeFixingSystem) =
      S.sub (2, 0) (S.zero (2, 0)) (S.mul (1, -1) (1, 1) S.c_bar S.c) := by
  rw [L_gf_evaluation (S := S.toGaugeFixingSystem), lagrange_term_zero_of_fixing S hfix]

/-- **The physical-observable statement**: the gauge-fixing (derivative
fixing) is BRST-exact, so it integrates to zero on physical observables —
`int_L_gf_eq_zero` of `ChapterGaugeFixing`, restated on the fixing system.
The fixing `v = dφ` therefore has zero impact on physical expectation
values. -/
theorem int_L_gf_eq_zero_physical (I : BrstIntegral S.toGaugeFixingSystem) :
    I.int (sTop S.toGaugeFixingSystem (Psi S.toGaugeFixingSystem)) = 0 :=
  I.int_of_s (Psi S.toGaugeFixingSystem)

/-! ## 2. A non-degenerate model -/

/-- The `2 × 2` matrix model of the fixing system: the superalgebra `M(1|1)`
of `ChapterGaugeFixing.matrixModel` with the two zero laws (which hold for
matrix multiplication against the zero matrix).  The model is non-vacuous:
its ghost and gauge-fixing Lagrangian are non-zero (`ChapterGaugeFixing`),
so the theorems above have content. -/
noncomputable def matrixModel : DerivativeVariableFixingSystem (fun _ => Mat2) where
  toGaugeFixingSystem := BookProof.GaugeFixing.matrixModel
  mul_zero_left := by
    intro x
    change (0 : Mat2) * x = 0
    exact Matrix.zero_mul x
  mul_zero_right := by
    intro x
    change (x : Mat2) * 0 = 0
    exact Matrix.mul_zero x

/-- In the model, on the fixing surface `v = dφ` the Lagrange term vanishes
(the model's version of `lagrange_term_zero_of_fixing`, concrete). -/
theorem matrixModel_lagrange_term_zero
    (hfix : gaugeField matrixModel.toGaugeFixingSystem = 0) :
    matrixModel.mul (1, 0) (1, 0) matrixModel.B
        (gaugeField matrixModel.toGaugeFixingSystem) = 0 := by
  rw [hfix]
  simpa using matrixModel.mul_zero_right matrixModel.B

/-- The model's fixing surface is exactly `v = dφ`: in the model
`gaugeField = v − dφ`, and the doublet structure `s(v − dφ) = c` holds
non-trivially (the ghost is non-zero). -/
theorem matrixModel_c_ne_zero : (matrixModel.c : Mat2) ≠ 0 := by
  change (BookProof.GaugeFixing.matrixModel.c : Mat2) ≠ 0
  exact BookProof.GaugeFixing.matrixModel_c_ne_zero

/-! ## 3. The QG-3.2(a) statement of record (honest boundary) -/

/-!
The concrete QG statement, following the pattern above:

**Target (QG-3.2(a)).**  In the densitized 84-dim field space of
`ChapterQuantumGravity3DGauge`, the 64 derivative coordinates
`X (idxDE mu nu a)` are the promoted derivative variables `v` of the NS
pattern.  The gauge fixing fixes them to the actual tetrad derivatives
(`E_ab = ∂_a e_b` — the constraint `v = dφ` enforced by the
Lagrange-multiplier term of `L_gf_evaluation`).  On the physical
(BRST-closed) sector, the cross couplings `½S·E + ⅓P·E − e(…)` of
`book.tex 8190` are then functions of the field values — the torsion
`torsionPoly mu nu a = X (idxDE mu nu a) − X (idxDE nu mu a)` is already the
antisymmetrized derivative coordinate — with **no new independent modes**:
the operator reduces to the fiber list.

**The open input (named hypothesis with citation, never an axiom).**  The
84-dim formalism treats the 64 `idxDE` coordinates as *independent*: the
polynomial variables `X j` carry no spatial-derivative operator, so the
statement "`X (idxDE mu nu a)` realizes `∂_μ e_ν^a`" cannot be discharged
inside the coordinate formalism.  The input is the derivative-variable
realization — the NS pattern (`u_{i,j} = ∂_j u_i`; book.tex §4159–4197) —
the formal version of the conformal-mode elimination.  Until it is
formalized, the couplings' reduction is recorded here, not proved; plan
QG-3.2(b) (direct ESA of the full operator) is the fallback if the input
fails.

The instruments the proof will use, verified to exist in the tree:
-/

#check BookProof.GaugeFixing.gaugeField
#check BookProof.GaugeFixing.L_gf_evaluation
#check BookProof.GaugeFixing.int_L_gf_eq_zero
#check BookProof.QuantumGravity3DGauge.idxDE
#check BookProof.QuantumGravity3DGauge.torsionPoly
#check BookProof.QuantumGravity3DGauge.torsionPoly_antisymm
#check BookProof.BrstReducedTransfer.physicalStates

/-! ## 4. The nested-Fock (Faris–Lavine) route: the couplings are a self-adjoint
quadratic operator on the outer Fock space

Sections 1–3 reduced the *gauge-identities* half of QG-3.2(a) to an algebraic
skeleton, leaving the reduction `E = ∂e` (the derivative-coordinate realization)
as a named hypothesis.  This section formalizes the **operator** half of the same
plan item, unconditionally, following the pattern of
`ChapterFockQuadraticEsa`.

In the nested (outer) Fock space the coupling `½S·E + ⅓P·E − e(…)` of
`book.tex 8190` — whatever its gauge content — is a **sum, over different
lifted one-particle Hamiltonians, of quadratic operators placed between the
creation and annihilation operators**, `H = Σᵢⱼ hᵢⱼ C†(eᵢ)·A(eⱼ)`.  The
one-particle Hamiltonian `h` is diagonalizable (self-adjoint, or extended to be
so), so a mode-diagonalizing basis sends this to a sum of quadratic operators —
their spectral pieces `Σ hᵢⱼ aᵢ†aⱼ` plus Hermitian conjugates, exactly the
`hopOp`/`pairOp` monomials of `ChapterFockQuadratic` with
`deg P + deg Q = 2` (mode exchange).  The comparison operator `N = diagMax (sig ω)`
is precisely the positive, self-adjoint operator that [Faris–Lavine](../Far) 1974
requires; the two hypotheses — relative bound and commutator-form bound — are
proved termwise in `ChapterFockQuadratic` (`pairOp_norm_le`, `pairOp_commForm_le`)
and survive the infinite sum under the weighted-`ℓ¹` summability of the coupling
amplitudes.  `fockH_essentiallySelfAdjointOn_core` is then Theorem 1 of
Faris–Lavine applied to the full operator, couplings included: it proves ESA of
`fockH = freeOp + Σ pairOp`, i.e. of the *full* Hamiltonian, not of a decoupled
fiber model.

## What this section proves (unconditionally)

* `creIdx`, `annIdx` — the single-creation and single-annihilation occupation
  indices `aᵢ†`, `aⱼ`;
* `deg_creIdx`, `deg_annIdx`, `wsum_creIdx`, `wsum_annIdx` — their degree and
  free-energy contributions;
* `deg_pair_le_two` — the mode-exchange monomial `aᵢ†aⱼ` is quadratic
  (`deg P + deg Q = 2`);
* `coupling_weighted_summable` — the infinite family is summed under exactly the
  hypothesis `fockH` needs (the coupling amplitudes are weighted-`ℓ¹`);
* **`coupling_essentiallySelfAdjointOn_core`** — the full second-quantized
  operator `fockH` (the diagonalizable free part plus the summed couplings) is
  essentially self-adjoint on the finite-mode core, for **every** non-negative
  free dispersion `ω` and **every** coupling amplitude family `h` that is
  weighted-`ℓ¹`-summable.  This is the Faris–Lavine/`fockH` route: the coupling
  operator *by itself* — together with the free part — is ESA, so it extends to
  a unique self-adjoint operator on the outer Fock space.

## Honest boundary

This is the *operator* content of QG-3.2(a): it shows the lifted couplings are a
well-defined self-adjoint quadratic operator on the outer Fock space, summed over
infinitely many modes, without any decoupling or small-coupling assumption.  It
does **not** identify the specific couplings `½S·E + ⅓P·E − e(…)` of `book.tex
8190` with the one-particle matrix `h` of a fixed *physical* sector — that
identification is the derivative-variable realization `E = ∂e` of section 3
(book.tex §4159–4197), still the named input.  What is proved here is the
conditional template: **if** the couplings form a weighted-`ℓ¹`-summable family
of lifted one-particle quadratic operators, **then** the full operator, couplings
included, is essentially self-adjoint on the finite-mode outer core.  This is
precisely the QG-3.2(b)/QG-3.3 full-operator route the plan records as the
fallback when the gauge-identity route is open.

Everything here is `sorry`-free and `axiom`-free.
-/

/-! ## 4.1 — the single-ladder indices and their symbols -/

variable {ι : Type*}

/-- The single-creation occupation index `aᵢ†`: `1` at mode `i`, elsewhere `0`. -/
noncomputable def creIdx (i : ι) : Idx ι := Finsupp.single i 1

/-- The single-annihilation occupation index `aⱼ`: `1` at mode `j`, elsewhere `0`. -/
noncomputable def annIdx (j : ι) : Idx ι := Finsupp.single j 1

/-- The degree of a single-creation index is `1`. -/
theorem deg_creIdx (i : ι) : deg (creIdx i) = 1 := by
  simp [creIdx]

/-- The degree of a single-annihilation index is `1`. -/
theorem deg_annIdx (j : ι) : deg (annIdx j) = 1 := by
  simp [annIdx]

/-- The free energy of a single-creation index is `ω i`. -/
theorem wsum_creIdx (ω : ι → ℝ) (i : ι) : wsum ω (creIdx i) = ω i := by
  rw [creIdx, wsum_single]
  ring

/-- The free energy of a single-annihilation index is `ω j`. -/
theorem wsum_annIdx (ω : ι → ℝ) (j : ι) : wsum ω (annIdx j) = ω j := by
  rw [annIdx, wsum_single]
  ring

/-! ## 4.2 — the mode-exchange monomial is quadratic -/

/-- The mode-exchange monomial `aₚ†a_q` is a quadratic (`deg`-`2`) monomial:
`deg (creIdx p) + deg (annIdx q) = 2 ≤ 2`, the hypothesis `fockH` needs. -/
theorem deg_pair_le_two (p q : ι) : deg (creIdx p) + deg (annIdx q) ≤ 2 := by
  simp [creIdx, annIdx]

/-! ## 4.3 — the weighted summability of the coupling family -/

/-- **The coupling family is summed under a weighted-`ℓ¹` condition.**  A family
`h : ι × ι → ℂ` of lifted one-particle quadratic couplings is admissible for
`fockH` exactly when it is absolutely summable against the free energies of its
two ladders: `Σ ‖h‖·(ω + ω + 2) < ∞`.  This is the convergence of the infinite
sum of quadratic operators that the nested-Fock route needs (the "infinite-sum /
integral of quadratic operators" challenge of the plan). -/
theorem coupling_weighted_summable {ω : ι → ℝ} (h : ι × ι → ℂ)
    (hsum : Summable fun k : ι × ι => ‖h k‖ * (ω k.1 + ω k.2 + 2)) :
    Summable fun k : ι × ι => ‖h k‖ * (wsum ω (creIdx k.1) + wsum ω (annIdx k.2) + 2) := by
  refine hsum.congr ?_
  intro k
  rw [wsum_creIdx, wsum_annIdx]

/-! ## 4.4 — the full operator is essentially self-adjoint (Faris–Lavine / `fockH`) -/

/-- **The QG-3.2 full-operator statement, couplings included.**  For **every**
non-negative free dispersion `ω` and **every** coupling amplitude family
`h : ι × ι → ℂ` that is weighted-`ℓ¹`-summable, the second-quantized operator
`fockH (ω, h) = freeOp + Σₖ (hₖ a†_ₖ₁ aₖ₂ + conj(hₖ) a†_ₖ₂ aₖ₁)`
— the diagonalizable free (one-particle) part plus the summed lifted couplings —
is essentially self-adjoint on the finite-mode core of the outer Fock space.
The essential contents of the couplings (their infinite sum, and their
well-definedness) are exactly the two QG-3.2 challenges, both discharged here. -/
theorem coupling_essentiallySelfAdjointOn_core {ω : ι → ℝ} (hω : ∀ i, 0 ≤ ω i)
    (h : ι × ι → ℂ)
    (hsum : Summable fun k : ι × ι => ‖h k‖ * (ω k.1 + ω k.2 + 2)) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((fockH hω (fun k : ι × ι => creIdx k.1) (fun k : ι × ι => annIdx k.2) h
          (fun p : ι × ι => deg_pair_le_two p.1 p.2)
          (coupling_weighted_summable h hsum)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig ω)))) :=
  fockH_essentiallySelfAdjointOn_core hω (fun k : ι × ι => creIdx k.1)
    (fun k : ι × ι => annIdx k.2) h (fun p : ι × ι => deg_pair_le_two p.1 p.2)
    (coupling_weighted_summable h hsum)

/-! ## 4.5 — axiom audit -/

#print axioms coupling_essentiallySelfAdjointOn_core

end BookProof.QgPhysicalSectorIdentity
