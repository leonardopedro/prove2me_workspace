import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesFockEsa
import Definitions.Def_ChapterStoneBridge
import Mathlib


/-!
# The graded (bosonic ⊗ fermionic) Fock space of quantum gravity — Part E

`PLAN_LEAN_SPECIALIST_QG_FLOW.md` Part E (`CONSOLIDATED_PLAN.md` §10.6.2 item 3) asks for
the second quantization of the gauge-fixed gravity Hamiltonian on the book's graded Fock
space

`Γˢ(L²(ℝ⁸⁴ × ℤ₂¹⁹)) ⊗ Γᵃ(L²(ℝ⁸⁴ × ℤ₂¹⁹))`,

the tensor product of a symmetric (bosonic) and an antisymmetric (fermionic, ghost) Fock
space, together with the `ℤ₂`-graded superalgebra of its creation and annihilation
operators.  The bosonic half is a direct reuse of
`BookProof/ChapterFockSecondQuantization.lean` (the Yang–Mills Part F.11 module); the new
content of this module is the **fermionic (CAR) half and the `ℤ₂` grading**.

## What is proved here

* **The fermionic configurations and the Jordan–Wigner sign.**  A fermionic configuration
  is a finite set of occupied modes (`FermConf = Finset ℕ`; the Pauli principle is built
  into the *set*, not imposed), and `jwSign j α = (−1)^{#\{i ∈ α : i < j\}}` is the sign
  that orders the mode `j` against the already occupied lower modes.
* **The ladder operators** `fermAnn j`, `fermCre j` on the algebraic fermionic Fock space
  `FermAlg = FermConf →₀ ℂ`, with their coordinate formulas `fermAnn_apply`,
  `fermCre_apply`, and the **canonical anticommutation relations** (E.3)
  * `car_fermAnn_fermCre` — `{ψ_j, ψ_j†} = 1`;
  * `car_fermAnn_fermCre_of_ne` — `{ψ_j, ψ_k†} = 0` for `j ≠ k`;
  * `car_fermAnn_fermAnn`, `car_fermCre_fermCre` — `{ψ_j, ψ_k} = {ψ_j†, ψ_k†} = 0`;
  * `fermAnn_comp_self`, `fermCre_comp_self` — hence `ψ_j² = (ψ_j†)² = 0`, the Pauli
    exclusion principle in operator form.
  `inner_fermCre_left` checks on the Hilbert space `ℓ²(FermConf)` that `ψ_j†` really is the
  adjoint of `ψ_j`, so the CAR are relations between an operator and its adjoint.
* **The `ℤ₂` grading** (E.4).  `fermGrade` is the parity operator `Γ = (−1)^F`, with
  `fermGrade_involutive`; the ladder operators are **odd** (`fermGrade_fermAnn`,
  `fermGrade_fermCre`), and `superBracket` is the graded bracket
  `[x, y} = xy − (−1)^{|x||y|} yx`, for which `superBracket_fermAnn_fermCre` restates the
  CAR and `superBracket_bosOp_ghostOp` says bosonic and ghost operators supercommute.
* **The graded state space** `QGGraded = FockAlg ⊗ FermAlg` with `bosOp` and `ghostOp`, the
  commutation `bosOp_ghostOp_comm`, the canonical relations `qgCCR` (bosonic) and
  `qgGhostCar` (fermionic) transported to it, and `qgGrade`, the total parity, for which
  `bosOp_even` and `ghostOp_odd` fix the degrees.
* **The graded Fock space and its Hamiltonian** (E.5, E.5b, E.6).  `GradedIdx =
  Conf × FermConf` indexes the joint occupation states; `qgGradedSymbol ω g` is the total
  energy `∑ₖ nₖ ωₖ + ∑_{a ∈ α} gₐ` of a boson configuration together with a ghost
  configuration, `qgGradedHam` the corresponding operator on the finite-occupation domain,
  and
  * **`qgGradedFock_esa`** — it is essentially self-adjoint there, with **no** boundedness
    or positivity assumption on either the boson or the ghost energies (the QG operator is
    indefinite, so this matters), and
  * **`qgGradedFock_stone_flow`** — hence it generates the unitary group `e^{−itH}` on the
    graded Fock space.
  `qgGradedFock_not_bounded` records that this is not a boundedness phenomenon.
  `qgDGamma_esa` and `qgTwoLevel_esa` register the general (bosonic) second-quantization
  and Fock-of-Fock theorems the plan asks to reuse, and `qgFock_hashimoto_selects`
  instantiates the shift-invert selection theorem on the Gauss–polynomial core of
  `L²(ℝ⁸⁴)`.

## Honest boundary

The Hamiltonian second-quantized here is the **particle-number preserving** one: a real
one-particle symbol for the bosons and a real ghost energy, with no sector-changing
interaction and no BRST charge (that is `ChapterQuantumGravityBrstCharge`, whose ghost CAR
on `Λ(ℂ¹⁹)` is the finite-mode counterpart of the fermionic half built here).  The
continuum one-particle essential self-adjointness of the full gauge-fixed operator on
`L²(ℝ⁸⁴ × ℤ₂¹⁹)` is *not* claimed; it is the hypothesis that the Fock-level theorems
consume.  No mass gap and no global existence is claimed.
-/

namespace BookProof.QuantumGravityFock

open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

/-! ## E.1/E.2 — the bosonic half (reuse)

The bosonic configurations, the algebraic Fock space and the ladder operators are those of
`BookProof.FockSecondQuantization`; only their gravity-facing names are new. -/

/-- The bosonic (one-particle mode) configurations of the gravity Fock space. -/
abbrev BoseConf := BookProof.FockSecondQuantization.Conf

/-- The algebraic bosonic Fock space. -/
abbrev BoseAlg := BookProof.FockSecondQuantization.FockAlg





/-! ## E.3 — the fermionic (ghost) half: configurations and the Jordan–Wigner sign -/

/-- A **fermionic configuration**: the finite set of occupied ghost modes.  The Pauli
principle is built into the representation — a mode is occupied or not. -/
abbrev FermConf := Finset ℕ

/-- The **algebraic fermionic Fock space**: finite linear combinations of fermionic
configurations. -/
abbrev FermAlg := FermConf →₀ ℂ

/-- The number of occupied modes below `j`: the Jordan–Wigner string length. -/
def jwCount (j : ℕ) (α : FermConf) : ℕ := (α.filter (fun i => i < j)).card

/-- The **Jordan–Wigner sign** `(−1)^{#\{i ∈ α : i < j\}}` picked up when the mode `j` is
moved past the occupied modes below it. -/
def jwSign (j : ℕ) (α : FermConf) : ℂ := (-1) ^ jwCount j α































/-! ## E.3 — the fermionic ladder operators and the CAR -/

/-- **The fermionic annihilation operator** of the mode `j`: on a configuration state,
`ψ_j |α⟩ = 0` if the mode is empty, and `(−1)^{jw} |α ∖ \{j\}⟩` if it is occupied. -/
def fermAnn (j : ℕ) : FermAlg →ₗ[ℂ] FermAlg :=
  Finsupp.lsum ℂ fun β => LinearMap.toSpanSingleton ℂ FermAlg
    (if j ∈ β then Finsupp.single (β.erase j) (jwSign j β) else 0)

/-- **The fermionic creation operator** of the mode `j`: on a configuration state,
`ψ_j† |α⟩ = 0` if the mode is already occupied (Pauli), and `(−1)^{jw} |α ∪ \{j\}⟩` if it
is empty. -/
def fermCre (j : ℕ) : FermAlg →ₗ[ℂ] FermAlg :=
  Finsupp.lsum ℂ fun β => LinearMap.toSpanSingleton ℂ FermAlg
    (if j ∈ β then 0 else Finsupp.single (insert j β) (jwSign j β))





















/-! ## The fermionic Fock space `ℓ²(FermConf)` and the adjoint pairing -/

/-- The fermionic Fock space `ℓ²` over the fermionic configurations. -/
abbrev FermFock := lp (fun _ : FermConf => ℂ) 2

/-- A finitely supported fermionic state as an element of `ℓ²(FermConf)`. -/
def fermToLp (u : FermAlg) : FermFock :=
  ⟨fun α => u α, memLpTwo_of_finite_support u.finite_support⟩















/-! ## E.4 — the `ℤ₂` grading and the superbracket -/

/-- **The total fermionic parity operator** `Γ = (−1)^F` on the fermionic Fock space. -/
def fermGrade : FermAlg →ₗ[ℂ] FermAlg :=
  Finsupp.lsum ℂ fun β => LinearMap.toSpanSingleton ℂ FermAlg
    (Finsupp.single β ((-1 : ℂ) ^ β.card))











/-- The sign `(−1)^{pq}` of the superalgebra: `−1` exactly when both degrees are odd. -/
def sgnDeg (p q : ZMod 2) : ℂ := if p = 1 ∧ q = 1 then -1 else 1

/-- **The graded (super) bracket** `[x, y} = xy − (−1)^{|x||y|} yx` of two operators of
degrees `p` and `q`. -/
def superBracket {V : Type*} [AddCommGroup V] [Module ℂ V] (p q : ZMod 2)
    (A B : V →ₗ[ℂ] V) : V →ₗ[ℂ] V :=
  A ∘ₗ B - sgnDeg p q • (B ∘ₗ A)















/-! ## The graded state space `Γˢ ⊗ Γᵃ` -/

/-- **The graded (bosonic ⊗ ghost) algebraic state space** of the book's Hilbert space
`Γˢ(L²(ℝ⁸⁴ × ℤ₂¹⁹)) ⊗ Γᵃ(L²(ℝ⁸⁴ × ℤ₂¹⁹))`. -/
abbrev QGGraded := TensorProduct ℂ BoseAlg FermAlg

/-- A bosonic operator acting on the graded state space. -/
def bosOp (A : BoseAlg →ₗ[ℂ] BoseAlg) : QGGraded →ₗ[ℂ] QGGraded :=
  TensorProduct.map A LinearMap.id

/-- A ghost (fermionic) operator acting on the graded state space. -/
def ghostOp (B : FermAlg →ₗ[ℂ] FermAlg) : QGGraded →ₗ[ℂ] QGGraded :=
  TensorProduct.map LinearMap.id B















/-- **The total `ℤ₂` grading** of the graded state space: the fermionic parity, extended
by the identity on the bosonic factor. -/
def qgGrade : QGGraded →ₗ[ℂ] QGGraded := ghostOp fermGrade









/-! ## The `19` diffeomorphism ghosts of the book

`ℤ₂¹⁹` = 4 diffeomorphism ghosts `ψ_μ` + 16 ghost derivatives `∂_μ ψ_ν` − 1. -/

/-- The number of ghost modes of the book's gravity Fock space. -/
def qgGhostModes : ℕ := 19





/-! ## E.5, E.5b, E.6 — the graded Fock Hamiltonian and its essential self-adjointness -/

/-- The joint occupation index of the graded Fock space: a bosonic configuration together
with a ghost configuration. -/
abbrev GradedIdx := BoseConf × FermConf

/-- The total ghost energy of a ghost configuration. -/
def ghostEnergy (g : ℕ → ℝ) (α : FermConf) : ℝ := ∑ a ∈ α, g a





/-- **The symbol of the graded Fock Hamiltonian**: the total boson energy `∑ₖ nₖ ωₖ` plus
the total ghost energy `∑_{a ∈ α} gₐ` of the joint occupation state.  Neither energy is
assumed bounded, bounded below, or of a fixed sign — the gauge-fixed gravity symbol is
indefinite. -/
def qgGradedSymbol (omega g : ℕ → ℝ) : GradedIdx → ℝ :=
  fun p => BookProof.NavierStokesFlow.FockOfFock.confEnergy omega p.1 + ghostEnergy g p.2





/-- **The graded Fock Hamiltonian** `dΓ(ω) ⊗ 1 + 1 ⊗ dΓ(g)`, as the diagonal operator with
symbol `qgGradedSymbol` on the finite-occupation domain of `ℓ²(GradedIdx)`. -/
def qgGradedHam (omega g : ℕ → ℝ) :
    lpFiniteModes GradedIdx →ₗ[ℂ] lpFiniteModes GradedIdx :=
  lpDiag (qgGradedSymbol omega g)













/-! ### The general second-quantization theorems the plan asks to reuse -/







end

end BookProof.QuantumGravityFock
