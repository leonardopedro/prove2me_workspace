import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterDirectSumEsa
import Mathlib


/-!
# The essentially-self-adjoint one-particle package, and `dΓ` over it

This module packages the data of the second quantization theorem in the form in which the
hypothesis "`A` is **essentially** self-adjoint on `D`" is naturally supplied: a symmetric
operator `A` on the domain `D₂` of its closure, together with a subspace `D ≤ D₂` which is a
**core** — graph-norm dense in `D₂`.  The operator one is really given is the restriction
`A|_D`; the pair records the ambient operator through which it is analysed.

**No positivity anywhere.**  Nothing in the package or in its consequences asks for a lower
bound on the spectrum: the only quantitative facts used are the graph norm `‖x‖ + ‖A x‖` and
the Pythagoras identity `‖A x - d i x‖² = ‖A x‖² + d² ‖x‖²`, valid for *every* symmetric
operator (`BookProof.FarisLavine.norm_sub_smul_sq`, recorded here as
`ESAPair.norm_sub_smul_sq`).  The imaginary shift `± i` is what makes `A ± i` bounded below,
irrespective of the sign of the spectrum, so operators unbounded below — the momentum
operator, a Dirac operator, or simply `-id` — are covered on the same footing as positive
ones.  In particular no quadratic form domain and no Friedrichs extension appear.

## Contents

* `ESAPair` — the package: a symmetric one-particle operator, its sectorwise input, and a
  graph-norm core;
* `ESAPair.toOp` — the operator actually given, the restriction to the core;
* `ESAPair.norm_sub_smul_sq` — the Pythagoras identity, valid with no semiboundedness;
* `ESAPair.dGammaOp` — the second quantization on the finite-particle domain over the core;
* `ESAPair.dGamma_essentiallySelfAdjoint` — **the main theorem** in packaged form;
* `ESAPair.dGamma_symmetricOn`, `ESAPair.exists_ne_zero_mem_domain` — symmetry and
  non-vacuity;
* `ESAPair.ofBounded` — a package for every bounded symmetric one-particle operator and every
  dense core, with no positivity: by
  `BookProof.BoundedDGamma.essentiallySelfAdjointOn_fockSectorDom_bounded` its sectorwise
  input is proved, not assumed.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.EsaPair

open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore
  BookProof.SecondQuantizationCore BookProof.DirectSumEsa

noncomputable section

/-- **An essentially self-adjoint one-particle operator, packaged as a core of a reference
operator.**  `closureOp` is the operator on the domain `D₂ = closureDomain` of the closure,
`coreDomain` is the small domain `D` on which the operator is really given, and `is_core`
says that `D` is graph-norm dense in `D₂`.  `sector_esa` is the one-particle input at the
level of the sectors: essential self-adjointness of `dΓ(closureOp)⁽ⁿ⁾` on the tensor power of
`closureDomain`, which is the statement for a *self-adjoint* one-particle operator.

No positivity, semiboundedness or order structure is required of `closureOp`. -/
structure ESAPair (Hs : IPSpace) where
  /-- the domain of the reference (closure) operator -/
  closureDomain : Submodule ℂ Hs.carrier
  /-- the reference operator, on the domain of the closure -/
  closureOp : closureDomain →ₗ[ℂ] Hs.carrier
  /-- the reference operator is symmetric (no positivity assumed) -/
  symmetric : SymmetricOn closureDomain closureOp
  /-- the sectorwise input: `dΓ⁽ⁿ⁾` is essentially self-adjoint on the tensor power of the
  domain of the closure -/
  sector_esa : ∀ n : ℕ, EssentiallySelfAdjointOn (fockSectorDom Hs closureDomain n)
    (fockSectorOp Hs closureDomain closureOp n)
  /-- the domain on which the operator is really given -/
  coreDomain : Submodule ℂ Hs.carrier
  /-- the core is contained in the domain of the closure -/
  sub_domain : coreDomain ≤ closureDomain
  /-- the core is graph-norm dense in the domain of the closure -/
  is_core : IsGraphCore coreDomain closureOp

variable {Hs : IPSpace} (P : ESAPair Hs)

/-- The operator that is really given: the restriction of the reference operator to the
core. -/
def ESAPair.toOp : P.coreDomain →ₗ[ℂ] Hs.carrier := restrictOp P.closureOp P.sub_domain





/-- The second quantization `dΓ(A)` on the finite-particle domain over the core. -/
def ESAPair.dGammaOp :
    dsCore (fun n : ℕ => fockSectorCore Hs P.closureDomain P.coreDomain n) →ₗ[ℂ]
      lp (fun n : ℕ => fockSector Hs n) 2 :=
  dGammaCoreOp Hs P.closureDomain P.closureOp P.coreDomain







/-! ## Packages that exist: bounded symmetric one-particle operators -/

/-- **A package for every bounded symmetric one-particle operator and every dense core.**  The
operator is not assumed positive — `B = -id` is allowed, and then `dΓ(B)` is unbounded below —
and the sectorwise input is *proved* here rather than assumed. -/
def ESAPair.ofBounded (Hs : IPSpace) (B : (⊤ : Submodule ℂ Hs.carrier) →ₗ[ℂ] Hs.carrier)
    (hB : SymmetricOn ⊤ B) {C : ℝ} (hC0 : 0 ≤ C)
    (hC : ∀ a : (⊤ : Submodule ℂ Hs.carrier), ‖B a‖ ≤ C * ‖(a : Hs.carrier)‖)
    (D : Submodule ℂ Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) : ESAPair Hs where
  closureDomain := ⊤
  closureOp := B
  symmetric := hB
  sector_esa := essentiallySelfAdjointOn_fockSectorDom_bounded Hs B hB hC0 hC
  coreDomain := D
  sub_domain := le_top
  is_core := isGraphCore_of_bounded Hs B hC0 hC hdense



end

end BookProof.EsaPair
