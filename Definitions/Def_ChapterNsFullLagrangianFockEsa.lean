import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterEsaClosureCore
import Mathlib


/-!
# ESA of the full (interacting) Lagrangian Navier–Stokes Hamiltonian on the finite-parcel core

`BookProof.ChapterNavierStokesFullLagrangianFock` defines the full Lagrangian Hamiltonian
`lagFullFockHam` on the nested Fock space `⊕ₙ L²(ℝ^{36n})`, with the finite-parcel core
`lagFockCore` (finitely many nonzero sectors, each a Gauss–polynomial). Its `n`-parcel sector
`lagSectorHam n = ½ Σ π² + ½ Σ form²` is interacting: the gauge-fixing forms couple
neighbouring parcels, and the Piola (`cof F · q`) and `det F − 1` forms have degree 2 and 3. So
it is not the second quantization of a one-body operator. That module proved only that
a positive self-adjoint (Friedrichs) extension exists.

Closing the gap needs no new analysis. Two existing theorems of the project do it:

* `YangMillsNonAbelianEsa.weylPoly_esa`: any operator `½ Σ_m π_{idx m}² + ½ Σ_j Φ_j²` on the
  Gauss–polynomial core of `L²(ℝᵈ)` is essentially self-adjoint when the momenta sit in
  distinct coordinates and the `Φ_j` are real polynomials. The proof writes `2H + 1 = −Δ_S + W`
  with `W = Σ Φ_j² + 1 ≥ 1` and uses the project's Kato-type theorem for degenerate
  Schrödinger operators with polynomial potentials.
* `DirectSumEsa.dsOp_essentiallySelfAdjointOn`: fibrewise essential self-adjointness glues to
  the orthogonal direct sum on the algebraic direct-sum core.

Proved here:

* `lagIdx_injective`: the 24 momentum directions of each parcel are distinct coordinates;
* `lagSectorHam_eq_weylPoly`: the `n`-parcel sector is such a Weyl-type operator (`rfl`);
* **`lagSectorHam_esa`**: every `n`-parcel sector is essentially self-adjoint on the
  Gauss–polynomial core of `L²(ℝ^{36n})`;
* **`lagFullFockHam_esa`**: the full Lagrangian Hamiltonian is essentially self-adjoint on
  the finite-parcel core `lagFockCore`;
* `lagFullFockHam_selfAdjointExtension_unique`: because the Hamiltonian is essentially
  self-adjoint, every self-adjoint extension of it has the same domain and values as the
  lifted Friedrichs realization `lagOuterComparison` of the earlier module, which is
  therefore *the* self-adjoint realization.

The Eulerian companion `BookProof.ChapterNavierStokesFullEulerianFock` has exactly the same
structure (21 coordinates and 12 momenta per parcel), and section 2 closes it the same way:
`nsSectorHam_esa`, **`nsFullFockHam_esa`** and `nsFullFockHam_selfAdjointExtension_unique`.

These hold for all real couplings `λ, λ', μ, g`. The statement is about the auxiliary
sum-of-squares operator of the earlier module, not about the (non-semibounded) Koopman
generator.
-/

namespace BookProof.NsFullLagrangianEsa

open MvPolynomial
open BookProof.NsFullLagrangian BookProof.YangMillsNonAbelianEsa BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs BookProof.HermiteProductCore BookProof.DirectSumEsa
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.EsaClosure

noncomputable section

/-- The global coordinate carrying the `m`-th momentum of the `n`-parcel sector. -/
def lagIdx (n : ℕ) (m : Fin (n * 24)) : Fin (n * 36) :=
  ycoord (finProdFinEquiv.symm m).1 (momIdx (finProdFinEquiv.symm m).2)

/-- The constraint forms of the `n`-parcel sector, as polynomials. -/
def lagForms (lam lam' mu gg : ℝ) (n : ℕ) (m : Fin (n * 28)) : MvPolynomial (Fin (n * 36)) ℂ :=
  lagFormOf lam lam' mu gg (finProdFinEquiv.symm m).1 (finProdFinEquiv.symm m).2















/-! ## 2. The Eulerian companion -/

/-- The global coordinate carrying the `m`-th momentum of the Eulerian `n`-parcel sector. -/
def eulIdx (n : ℕ) (m : Fin (n * 12)) : Fin (n * 21) :=
  NsFullEuler.ycoord (finProdFinEquiv.symm m).1 (NsFullEuler.momIdx (finProdFinEquiv.symm m).2)

/-- The constraint forms of the Eulerian `n`-parcel sector, as polynomials. -/
def eulForms (nu lam mu gg : ℝ) (n : ℕ) (m : Fin (n * 19)) : MvPolynomial (Fin (n * 21)) ℂ :=
  NsFullEuler.nsFormOf nu lam mu gg (finProdFinEquiv.symm m).1 (finProdFinEquiv.symm m).2













end

end BookProof.NsFullLagrangianEsa
