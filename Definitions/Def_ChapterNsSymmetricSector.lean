import Definitions.Def_ChapterNsOneBodyDGamma
import Definitions.Def_ChapterNsReducedCoreEsa
import Definitions.Def_ChapterFockStatisticsEsa
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib


/-!
# The Navier–Stokes one-body generator on the symmetric (bosonic) Fock sectors

The NS instance of the symmetrization machinery (work order step “NS symmetrization” of
`CONSOLIDATED_PLAN.md`).  The one-body generator of the Fourier-eliminated Eulerian sector,
`H_sp = ½ Σ_{m<6} π_m² + ½ Σ_{r<7} (mulOp Φ_r)²` (`NsOneBody.spHam`, advection included), acts on
the Gauss–polynomial core of `L²(ℝ⁶)`.  Here:

* `spHam_eq_weylPoly` (by `rfl`), **`spHam_esa`** — `H_sp` is essentially self-adjoint on
  `polyGaussCore 6` (one-particle statement), by the Kato-type theorem
  `YangMillsNonAbelianEsa.weylPoly_esa`;
* **`nsSp_bosonic_core_esa`** — for every particle number `n`, the `n`-parcel derivation
  `Σ_p 1 ⊗ ⋯ ⊗ H_sp ⊗ ⋯ ⊗ 1` reduced to the **symmetric** tensor power (the image of the
  permutation average `bosonicProj`, the permutation representation `permRep` commuting with
  the derivation and preserving `polyGaussCore^{⊗n}`) is essentially self-adjoint on the
  symmetrized tensor power of the core — `PermSector.essentiallySelfAdjointOn_bosonic_core`
  instantiated for NS;
* **`nsSp_bosonicFock_esa`**, **`nsSp_hbosonicFock_esa`** — `dΓ(H_sp)` is essentially
  self-adjoint on the bosonic Fock space over `polyGaussCore 6` (algebraic direct sum of the
  symmetric sectors, and Hilbert direct sum of their completions);
* **`nsSp_dGamma_esa`** — the unsymmetrized enclosure `dΓ(H_sp)` (creation left / annihilation
  right, `dGammaCoreOp`) is essentially self-adjoint on the finite-particle domain.

## Honest boundary

The statements are in the `IPSpace` tensor-power spelling of the second quantization.  The
unitary identification of the `n`-parcel space `L²(ℝ^{6n})` of `nsRedFullFockHam` with the
`n`-fold tensor power of `L²(ℝ⁶)`, and the identification with the `ℓ²`-spelling
`dGammaOp (nsSpCol e ν k)` of `ChapterNsOneBodyDGamma`, are not proved here.  The operator is
the positive sum-of-squares generator; the mainstream Koopman generator is never enclosed.  No
mass gap, uniqueness or global-existence statement is made.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.NsSymmetricSector

open scoped TensorProduct
open BookProof.NsOneBody BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.GraphCore
open BookProof.TensorCore BookProof.FockStatistics BookProof.PermSector BookProof.ReducedEsa
open BookProof.GroupAverage BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa

noncomputable section





/-- The one-body generator as an operator into the bundled space `L²(ℝ⁶)`. -/
def nsSpOp (nu : ℝ) (k : Fin 3 → ℝ) :
    polyGaussCore (d := 6) →ₗ[ℂ] (L2dSpace 6).carrier :=
  spHam (coreRepPoly 6) nu k













end

end BookProof.NsSymmetricSector
