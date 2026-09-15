import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
import Mathlib
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge


/-!
# Finite sections: one shift, one finite time, for any essentially self-adjoint mode Hamiltonian

`BookProof.ChapterSirkSingleTimeShift` proves that the SIRK/Hashimoto algorithm needs no
discretization of time — it evaluates the propagator at a *single finite time* through the
**bounded** shift-invert resolvent `(A − iℓ)⁻¹` — and `BookProof.ChapterQgTimeIndependentFlow`
turns "the gauge-fixed Hamiltonian carries no time dependence" into theorems about the
propagator.  Both were instantiated for the quantum-gravity Hamiltonian, where the
approximation analysed is the mode truncation of `BookProof.ChapterQgTruncationResolvent`.

This module supplies the approximation scheme for the *other* two Hamiltonians of the
project — Navier–Stokes and quantum Yang–Mills — which live on an `ℓ²` mode space
`L2I ι = ℓ²(ι)` with the finite-mode core `lpFiniteModes ι`.  The scheme is the **finite
section** (Galerkin) truncation: the matrix of the Hamiltonian in the mode basis, restricted
to a finite window `W` of modes,

`H_W = P_W H P_W`,   `P_W y = Σ_{k ∈ W} ⟪e_k, y⟫ e_k`.

Each `H_W` is a *bounded* (finite-rank) self-adjoint operator, so it has a unique
self-adjoint realization and its shift-invert resolvent is computable; and as the window
exhausts the modes the finite sections converge to the exact Hamiltonian on the core, hence
in the strong resolvent sense, hence — by Trotter–Kato — in the propagator sense at every
single finite time.

## What is proved

* `projW`, `projW_apply_tendsto` — the mode projection and its strong convergence to the
  identity along an exhausting family of windows.
* `secOp`, `secOp_isSelfAdjoint` — the finite section is a bounded self-adjoint operator
  (symmetry of the Hamiltonian on the core is the only input).
* `secOp_tendsto_core` — on every core vector the finite sections converge to the exact
  Hamiltonian.
* **`finiteSection_singleTime`** — the package: for a symmetric, essentially self-adjoint
  mode Hamiltonian there is a self-adjoint realization `T` and self-adjoint realizations
  `S n` of the finite sections such that
  * the propagator `U(t,s) = e^{−i(t−s)H}` is unitary, satisfies Chapman–Kolmogorov, is
    **time-translation invariant** and **uniquely** solves the Schrödinger equation with the
    one fixed generator (no time ordering, no Dyson series);
  * at **every** nonzero shift `ℓ` the bounded Hashimoto shift-invert operators
    `−(· − iℓ)⁻¹` of the finite sections converge strongly to that of `T`;
  * hence at **every single finite time** `t` the finite-section propagators converge to the
    exact one — no step size, no number of steps, no time splitting.
* `windowOfEquiv`, `windowOfEquiv_exhausts` — an admissible family of windows exists on
  every countable mode set.

Everything is `sorry`-free and `axiom`-free.  The Navier–Stokes and Yang–Mills instances are
`BookProof.ChapterNsTimeIndependentFlow` and `BookProof.ChapterQymTimeIndependentFlow`.
-/

open scoped InnerProductSpace

namespace BookProof.FiniteSectionSingleTime

open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.QgTruncationResolvent BookProof.SirkSingleTime
open BookProof.HashimotoShiftInvert
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {ι : Type*} [DecidableEq ι]

/-! ## 1. The mode basis and the mode projection -/

/-- The mode basis vector `e_k` of `ℓ²(ι)`. -/
def basisVec (k : ι) : L2I ι := lp.single 2 k (1 : ℂ)

/-- The mode basis vector, as an element of the finite-mode core. -/
def coreVec (k : ι) : lpFiniteModes ι := ⟨basisVec k, lpSingle_mem_lpFiniteModes k 1⟩









/-- The projection onto the modes in the finite window `W`. -/
def projW (W : Finset ι) : L2I ι →L[ℂ] L2I ι :=
  ∑ c ∈ W, (innerSL ℂ (basisVec c)).smulRight (basisVec c)



/-- The window family `W` **exhausts** the modes: every finite set of modes is eventually
contained in it. -/
def Exhausts (W : ℕ → Finset ι) : Prop := ∀ F : Finset ι, ∀ᶠ n in atTop, F ⊆ W n



/-! ## 2. The finite section of a mode Hamiltonian -/

variable (H : lpFiniteModes ι →ₗ[ℂ] L2I ι)

/-- **The finite section** `P_W H P_W` of the mode Hamiltonian `H`: the matrix of `H` in the
mode basis, restricted to the window `W`.  It is a finite-rank, hence bounded, operator — it
is what a Galerkin/Krylov scheme actually computes with. -/
def secOp (W : Finset ι) : L2I ι →L[ℂ] L2I ι :=
  ∑ a ∈ W, (innerSL ℂ (basisVec a)).smulRight (projW W (H (coreVec a)))





/-! ## 3. The finite sections converge to the Hamiltonian on the core -/







/-! ## 4. Bounded self-adjoint operators as self-adjoint extensions -/



/-! ## 5. The package: one shift, one finite time, no time dependence -/



/-! ## 6. The propagator of a *selected* self-adjoint extension -/



/-! ## 7. Admissible windows exist on every countable mode set -/

/-- The windows produced by an enumeration of the modes. -/
def windowOfEquiv (en : ℕ ≃ ι) (n : ℕ) : Finset ι := (Finset.range n).image en



end

end BookProof.FiniteSectionSingleTime
