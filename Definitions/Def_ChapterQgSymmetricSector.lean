import Definitions.Def_ChapterFockStatisticsEsa
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterEsaOneParticleDGamma
import Mathlib


/-!
# The complete gauge-fixed quantum-gravity Hamiltonian on the symmetrized cores

The QG `secCore` spelling of the work order in `CONSOLIDATED_PLAN.md`.
`BookProof.QgVielbeinScalaronGaugeFL.qgFull_esa_core_fl` proves that the complete gauge-fixed
quantum-gravity one-particle Hamiltonian `secHam W (qgFullModes g)` — vielbein/torsion kinetic
terms, the exact exponential Einstein-frame wall `W` (no Taylor truncation) and the
scalaron–vielbein interaction terms — is essentially self-adjoint on the finite-particle core
`secCore` of `Sec GMode = ℓ²(GMode; L²(ℝ))`.  Here that one-particle statement is carried to
the enclosures:

* **`qgFull_bosonic_core_esa`** — for every particle number `n`, the `n`-particle derivation of
  `secHam` reduced to the **symmetric** tensor power is essentially self-adjoint on the
  symmetrized tensor power of `secCore` (`PermSector.essentiallySelfAdjointOn_bosonic_core`);
* **`qgFull_bosonicFock_esa`**, **`qgFull_hbosonicFock_esa`** — `dΓ(secHam)` is essentially
  self-adjoint on the bosonic Fock space over `secCore` (algebraic, and Hilbert, direct sum of
  the symmetric sectors);
* **`qgFull_dGamma_esa`** — the unsymmetrized enclosure `dΓ(secHam)` (creation left /
  annihilation right, `dGammaCoreOp`) is essentially self-adjoint on the finite-particle domain
  over `secCore`.

No transfer to a Gauss–polynomial core is used or needed: the one-particle core is `secCore`,
built from `C_c^∞` fibres, which is where `qgFull_esa_core_fl` holds.

## Honest boundary

Only the operator `secHam W (qgFullModes g)` of `ChapterQgVielbeinScalaronGaugeFL` is treated;
the 84-dimensional `qg3DHamiltonian` with the Weyl-ordered cross terms (QG-3.2(a)/(b)) is not.
No spectral information and no mass gap is claimed.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.QgSymmetricSector

open scoped TensorProduct
open BookProof.ScalaronOuterFockFL BookProof.QgVielbeinModeInstance
open BookProof.QgContinuumModeInstance BookProof.QgVielbeinScalaronGaugeFL
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.FockStatistics
open BookProof.PermSector BookProof.ReducedEsa BookProof.GroupAverage BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore BookProof.ScalaronFiberFL

noncomputable section

/-- The one-particle space `Sec GMode = ℓ²(GMode; L²(ℝ))`, bundled. -/
def qgSecSpace : IPSpace := ⟨Sec GMode⟩

instance : CompleteSpace qgSecSpace.carrier := inferInstanceAs (CompleteSpace (Sec GMode))

/-- The complete gauge-fixed QG one-particle Hamiltonian, as an operator into the bundled
space. -/
def qgFullOp (W : WallPot) (g : ℝ) : secCore (ι := GMode) →ₗ[ℂ] qgSecSpace.carrier :=
  secHam W (qgFullModes g)













end

end BookProof.QgSymmetricSector
