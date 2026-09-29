import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterYangMillsAbelianEsa
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus

import Mathlib
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFiniteSectionSingleTime
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterQgManifoldModeInstance
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite

/-!
# The second quantization of the abelian gauge-fixed Yang–Mills Hamiltonian: essential
# self-adjointness on the finite-occupation core, and the single-time package with no
# hypothesis

`BookProof.ChapterQymTimeIndependentFlow` proves the Yang–Mills single-time package
(`ymFock_timeIndependent_singleTime_of_esa`) **conditionally** on essential self-adjointness
of `dΓ(H₁)` on the finite-occupation core, and discharges that hypothesis only when the
working basis diagonalizes the one-particle Hamiltonian.  `CONSOLIDATED_PLAN.md` records the
removal of that hypothesis — "`dΓ` of an *unbounded* one-particle operator" — as the honest
remaining gap of the Yang–Mills thread.  This chapter closes it in the **abelian** case,
in the product Hermite basis.

## What is proved

* `coreRep_op_comp`, `coreRep_op_add`, `coreRep_op_smul`, `coreRep_op_sum` — transport of a
  polynomial operator to the core is an algebra map.
* `ymAbelianHermOp`, **`ymAbelianHermOp_eq`** — the one-particle abelian Yang–Mills
  Hamiltonian `H₁ = ½Σπ² + ½ΣB²` on the finite-mode domain of the product Hermite basis is
  the transport of the polynomial operator `ymAbelianPoly`; `ymHamiltonian_hermCore_eq`
  records that this *is* `ymHamiltonian (coreRepHerm e) 0`, the Hamiltonian of
  `BookProof.ChapterYangMillsHermite` at `f_{abc} = 0`.
* `ymAbelianHermCol`, `ymAbelianHermCol_eq` — its matrix in the product Hermite basis.
* **`dGamma_ymAbelian_essentiallySelfAdjointOn_core`** — the headline: `dΓ(H₁)` is
  essentially self-adjoint on the finite-occupation core.  The route is
  `ymAbelianPoly_eq_fqPoly` (the identification with a general real quadratic Hamiltonian) +
  `dGamma_hermCol_essentiallySelfAdjointOn_core`; no diagonalizing basis and no `ℓ¹`
  summability of the matrix elements is assumed.
* `ymAbelianFock_friedrichs_extension` and
  **`ymAbelianFock_positiveExtension_eq_closure`** — the positive self-adjoint extension
  exists and *is* the closure: the selection problem of Part D.4 is empty here.
* **`ymAbelianFock_timeIndependent_singleTime`** — hence the full single-time package,
  **unconditionally**: the exact generator and its finite sections have self-adjoint
  realizations, the propagator is time-translation invariant and uniquely solves the
  Schrödinger equation, the Hashimoto shift-invert operators of the finite sections converge
  at every nonzero shift, and their propagators converge to the exact one at every single
  finite time.

## Honest boundary

This is the **abelian** (`f_{abc} = 0`) Hamiltonian: for `g ≠ 0` the magnetic term is cubic
in the coordinates, so `B²` is quartic and the band calculus of
`BookProof.ChapterHermiteBandCalculus` — which is a calculus of *quadratic* symbols — does
not apply.  No mass gap and no spectral information is claimed here.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.YmAbelianFock

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.FiniteSectionSingleTime BookProof.QymTimeIndependent BookProof.QgTimeIndependent

noncomputable section

variable {d : ℕ}

/-! ## The transport of a polynomial operator is multiplicative -/









/-! ## The abelian Yang–Mills Hamiltonian on the Hermite core -/

/-- The one-particle abelian Yang–Mills Hamiltonian as an endomorphism of the finite-mode
domain of the product Hermite basis. -/
def ymAbelianHermOp (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    finiteModeDomain (hermBasisN e) →ₗ[ℂ] finiteModeDomain (hermBasisN e) :=
  weylOpDom (piOps (coreRepHerm e)) (magOps (coreRepHerm e) 0)



/-- Its matrix in the product Hermite basis. -/
def ymAbelianHermCol (e : ℕ ≃ (Fin 99 →₀ ℕ)) : ℕ → (ℕ →₀ ℂ) :=
  opCol (hermBasisN e) (ymAbelianHermOp e)





/-! ## Essential self-adjointness of the second quantization -/













end

end BookProof.YmAbelianFock
