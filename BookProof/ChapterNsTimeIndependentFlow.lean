import Mathlib
import BookProof.ChapterFiniteSectionSingleTime
import BookProof.ChapterNavierStokesHashimoto
import BookProof.ChapterNavierStokesLagrangianCanonical
import BookProof.ChapterNavierStokesGaugeY

/-!
# The gauge-fixed Navier–Stokes Hamiltonian is time-independent, and one finite time suffices

This is the Navier–Stokes counterpart of `BookProof.ChapterQgTimeIndependentFlow`.

The Navier–Stokes thread of this project fixes the gauge in the *spatial* auxiliary
coordinate `y`: the field `u_i(y) = u_i + u_{i,j} y_j` carries the derivatives as independent
fields, the gauge generator `∂/∂y_j` annihilates the Hamiltonian symbol
(`BookProof.NavierStokesFlow.GaugeY.genY_nsSymbol`), and on the initial data `y = 0` the
symbol collapses to the ordinary Navier–Stokes expression `u_j u_{i,j} − ν u_{i,jj}`
(`setYZero_nsSymbol`).  No time derivative and no time parameter enters the construction, so
the quantized Hamiltonian is a single fixed self-adjoint operator — an **autonomous**
generator.  Together with `BookProof.ChapterSirkSingleTimeShift` (the SIRK/Hashimoto
algorithm evaluates the propagator at *one* finite time through the bounded shift-invert
resolvent) this removes any need for a discretization of time: no step size, no number of
steps, no time ordering, no Dyson series.

The approximation scheme is the **finite section** (Galerkin) truncation of
`BookProof.ChapterFiniteSectionSingleTime`: the matrix of the Hamiltonian in the Hermite
mode basis of `ℓ²(Vel)`, restricted to a finite window of modes.

## What is proved

* **`nsEulerian_timeIndependent_singleTime`** — for the coupled three-component Eulerian
  fiber Hamiltonian `H = Σ_i ½(π_i V_i + V_i π_i)`, `V_i(u) = Σ_k A_{ik} u_k + c_i`, on
  `ℓ²(Vel)`, `Vel = Fin 3 → ℕ` (arbitrary real velocity-gradient matrix `A` and constant
  vector `c`): a self-adjoint realization `T`; its propagator `U(t,s) = e^{−i(t−s)H}` is
  unitary, satisfies Chapman–Kolmogorov, is **time-translation invariant** and **uniquely**
  solves the Schrödinger equation of the one fixed generator; the finite sections have
  self-adjoint realizations whose Hashimoto shift-invert operators converge at **every**
  nonzero shift; and their propagators converge to the exact one at **every single finite
  time**.
* **`nsGaugeY_timeIndependent_singleTime`** — the same statement with the two gauge-fixing
  identities of the `y`-gauge as its first conjuncts: the Hamiltonian symbol is annihilated
  by the gauge generator `∂/∂y_j`, and at `y = 0` it is the ordinary Navier–Stokes symbol.
  This is the Navier–Stokes analogue of the first conjunct
  (`gaugeReduce_gram`) of `starobinsky_brstGaugeFixed_timeIndependent_singleTime`.
* **`nsLagrangian_timeIndependent_singleTime`** — the same for the canonical (ladder)
  realization of the **Lagrangian (parcel)** transformed Navier–Stokes Hamiltonian
  `ĥ_full = ½Σ P_i² + ν Σ Q_i² + Σ f_i P_i` on the trajectory-space Hermite basis, at every
  viscosity `ν > 0` and every external force `f`.

## Honest boundary

Unchanged from the rest of the Navier–Stokes thread (Contention D5): nothing here claims
global regularity of the *classical* Navier–Stokes PDE, and no spectral information is
claimed.  The setting is the sequence-space (Hermite/occupation-number) realization of the
fiber Hamiltonian.  What is proved is exactly the evolution statement: the generator carries
no time dependence, its propagator is the one-parameter group evaluated at a single finite
time, and the finite sections converge to it at every nonzero shift and every single finite
time.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.NsTimeIndependent

open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.FiniteSectionSingleTime
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.NSHashimoto
open BookProof.NavierStokesFlow.LagrangianEsa BookProof.NavierStokesFlow.LagrangianCanonical
open BookProof.NavierStokesFlow.LagrangianKatoRellich

noncomputable section

/-! ## 1. The Eulerian fiber Hamiltonian -/

/-- **The Eulerian Navier–Stokes evolution is autonomous, and one finite time suffices.**

For the coupled three-component fiber Hamiltonian on `ℓ²(Vel)` and its finite sections
(the Galerkin truncations in the Hermite mode basis, along the windows of an arbitrary
enumeration `en` of the modes):

* `H` has a self-adjoint realization `T`, and each finite section has a self-adjoint
  realization `S n`;
* the propagator `U(t,s)` of `T` is unitary, obeys Chapman–Kolmogorov, is **invariant under
  a common shift of both times** and **uniquely** solves the Schrödinger equation with the
  one fixed generator — no time ordering and no Dyson series occurs;
* at every nonzero shift `ℓ` the bounded Hashimoto shift-invert operators `−(· − iℓ)⁻¹` of
  the finite sections converge strongly to that of `T`;
* hence at **every single finite time** `t` the finite-section propagators converge to the
  exact one.  No step size, number of steps or time splitting appears anywhere. -/
theorem nsEulerian_timeIndependent_singleTime (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)
    (en : ℕ ≃ Vel) :
    ∃ (T : UnboundedSelfAdjoint (L2I Vel)) (S : ℕ → UnboundedSelfAdjoint (L2I Vel)),
      IsSelfAdjointExtension (velCore A c) T.op ∧
        (∀ n, IsSelfAdjointExtension
          (((secOp (velCore A c) (windowOfEquiv en n) : L2I Vel →ₗ[ℂ] L2I Vel)).comp
            (lpFiniteModes Vel).subtype) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : L2I Vel), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : L2I Vel), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → L2I Vel, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : L2I Vel,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : L2I Vel) (t : ℝ),
          Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  finiteSection_singleTime (velCore A c) (velCore_symmetricOn A c) (velCore_esa A c)
    (windowOfEquiv_exhausts en)

open BookProof.NavierStokesGaugeY in
/-- **The `y`-gauge-fixed Navier–Stokes Hamiltonian is time-independent, and the
SIRK/Hashimoto algorithm needs only one finite time.**

The first two conjuncts are the gauge-fixing identities themselves: the Navier–Stokes
Hamiltonian symbol `A_i = u_j(y) u_{i,j} − ν u_{i,jj}` is annihilated by the *spatial* gauge
generator `∂/∂y_j` (`genY_nsSymbol`), and on the initial data `y = 0` it is the ordinary
Navier–Stokes symbol `u_j u_{i,j} − ν u_{i,jj}` (`setYZero_nsSymbol`).  No time derivative
occurs in the gauge condition, so the quantized generator carries no time dependence, and
the remaining conjuncts are the evolution package of
`nsEulerian_timeIndependent_singleTime`. -/
theorem nsGaugeY_timeIndependent_singleTime (nu : ℂ) (A : Matrix (Fin 3) (Fin 3) ℝ)
    (c : Fin 3 → ℝ) (en : ℕ ≃ Vel) :
    (∀ i j : Fin 3, genY j (nsSymbol nu i) = 0) ∧
      (∀ i : Fin 3, setYZero (nsSymbol nu i) = nsSymbolPoint nu i) ∧
      ∃ (T : UnboundedSelfAdjoint (L2I Vel)) (S : ℕ → UnboundedSelfAdjoint (L2I Vel)),
        IsSelfAdjointExtension (velCore A c) T.op ∧
          (∀ n, IsSelfAdjointExtension
            (((secOp (velCore A c) (windowOfEquiv en n) : L2I Vel →ₗ[ℂ] L2I Vel)).comp
              (lpFiniteModes Vel).subtype) (S n).op) ∧
          (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
          (∀ (t s : ℝ) (x : L2I Vel), ‖prop T t s x‖ = ‖x‖) ∧
          (∀ (t s r : ℝ) (x : L2I Vel), prop T t s (prop T s r x) = prop T t r x) ∧
          (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
          (∀ y : ℝ → L2I Vel, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
          (∀ l : ℝ, l ≠ 0 →
            IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
              (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
              ∀ u : L2I Vel,
                Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
          ∀ (v : L2I Vel) (t : ℝ),
            Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  ⟨fun i j => genY_nsSymbol nu i j, fun i => setYZero_nsSymbol nu i,
    nsEulerian_timeIndependent_singleTime A c en⟩

/-! ## 2. The Lagrangian (parcel) Hamiltonian -/

/-- **The canonical Lagrangian Navier–Stokes evolution is autonomous, and one finite time
suffices.**  The Hamiltonian is `ĥ_full = ½ Σ P_i² + ν Σ Q_i² + Σ f_i P_i` in the canonical
(ladder) realization on the trajectory-space Hermite basis of `ℓ²(Vel)`, at viscosity
`ν > 0` and arbitrary external force `f`; its finite sections are the Galerkin truncations
in that basis.  The conclusion is the same package as in the Eulerian case. -/
theorem nsLagrangian_timeIndependent_singleTime (nu : ℝ) (hnu : 0 < nu) (f : Fin 3 → ℝ)
    (en : ℕ ≃ Vel) :
    ∃ (T : UnboundedSelfAdjoint (L2I Vel)) (S : ℕ → UnboundedSelfAdjoint (L2I Vel)),
      IsSelfAdjointExtension (lagrangianCore (lagCanData nu hnu f)) T.op ∧
        (∀ n, IsSelfAdjointExtension
          (((secOp (lagrangianCore (lagCanData nu hnu f)) (windowOfEquiv en n) :
              L2I Vel →ₗ[ℂ] L2I Vel)).comp (lpFiniteModes Vel).subtype) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : L2I Vel), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : L2I Vel), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → L2I Vel, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : L2I Vel,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : L2I Vel) (t : ℝ),
          Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  finiteSection_singleTime (lagrangianCore (lagCanData nu hnu f))
    (lagrangianCore_symmetricOn (lagCanData nu hnu f)) (lagCan_esa nu hnu f)
    (windowOfEquiv_exhausts en)

end

end BookProof.NsTimeIndependent
