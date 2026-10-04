import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterYangMillsHermite
import Mathlib


/-!
# The mainstream Navier–Stokes Koopman generator, linear part: essential self-adjointness
(NS mainstream leg, redesigned)

`BookProof.ChapterNsKoopman` defines the mainstream (Koopman–von Neumann) Navier–Stokes
Hamiltonian `H_NS = ½ Σ_m (π_m F_m + F_m π_m)`, `F = −νΛu + B(u,u)`, on the Gauss–polynomial
core, and `NsKoopman.nsKoopman_esa_of_energy_comparison` derived its essential
self-adjointness from a Faris–Lavine comparison with the Leray energy `N_E = 1 + ‖u‖²`,
**under** the hypothesis `hsurj` that `N_E + 1` maps the core onto `L²`.  That hypothesis is
false (`NsEnergySurjectivityObstruction.not_nsEnergy_surjective`), and — informally — no
multiplication operator dominates the first-order generator, so the Leray-energy route
cannot be repaired by a change of domain alone.

This module is the redesign of the leg in the part where it can be closed with the tools of
the project: **the generator of every affine drift is a real quadratic Hamiltonian**, so its
essential self-adjointness is an instance of the Carleman-flux theorem
`FullQuadratic.fqOp_essentiallySelfAdjoint`, with no comparison operator, no surjectivity and
no sign hypothesis.  This covers

* the **Stokes** system (no advection) — `nsKoopmanOp S` itself, for every mainstream system
  `S` whose advection vanishes (`nsKoopman_stokes_esa`);
* the **Oseen linearization** of the full Navier–Stokes drift about an *arbitrary* point `ū`
  (steady or not), `F(ū) + DF(ū)(u − ū)` with `DF(ū)_{ij} = −νλ_iδ_{ij} + Σ_k (b_{ijk} +
  b_{ikj}) ū_k` (`oseenKoopman_esa`);
* every **affine** drift `F(u) = A u + c` with real `A`, `c` (`linKoopman_esa`), with its
  Stone flow and its second quantization `dΓ` on the finite-occupation core.

## What is proved

* `linDrift A c i = Σ_j A_{ij} u_j + c_i`, `linKvnPoly A c = Σ_i ½(π_i F_i + F_i π_i)` — the
  Weyl-ordered generator of an affine drift;
* **`linKvnPoly_eq_fqPoly`** — it *is* the general quadratic Hamiltonian
  `fqPoly 0 0 Aᵀ 0 c` (no kinetic and no potential part: only the Weyl-ordered cross terms
  `½(u_jπ_i + π_iu_j)` and the momenta);
* `linKoopmanOp A c` (on the core) and **`linKoopman_esa`**, `linKoopman_stone_flow`,
  `linKoopman_dGammaOp_esa`;
* `drift_eq_linDrift_of_stokes`, **`nsKoopman_stokes_esa`** — for a mainstream system with
  vanishing advection the mainstream operator `nsKoopmanOp S` of `ChapterNsKoopman` is
  essentially self-adjoint;
* `oseenMat`, `oseenConst`, `oseenDrift_eq` (the affine drift is the first-order Taylor
  polynomial of the mainstream drift at `ū`: `drift S` and `linDrift` agree up to the
  quadratic remainder `B(u − ū, u − ū)`), **`oseenKoopman_esa`**.

## Honest boundary

* The **nonlinear** mainstream generator (advection `B ≠ 0`) is not covered: it is cubic, its
  Hermite matrix grows like `deg^{3/2}`, and neither the graded-band Schur gate nor the
  quadratic Carleman flux applies.  The route recorded for it is completeness of the classical
  flow (the energy inequality makes the Navier–Stokes Galerkin flow global in both time
  directions, and `div F = −ν Σ λ_i` is constant): the orbit criterion
  `FlowDGammaEsa.deficiencyTrivialAt_of_orbits` then needs a core invariant under the flow,
  i.e. the smooth dependence of the flow on its initial data, which Mathlib does not provide.
* The Oseen operator is the Koopman generator of the *linearized* flow, not a perturbation
  bound for the nonlinear one.
* No gap, spectrum, uniqueness or global-existence statement is made.
-/

namespace BookProof.NsLinearKoopmanEsa

open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section

variable {d : ℕ}

/-! ## 1. The generator of an affine drift -/

/-- The affine drift `F_i(u) = Σ_j A_{ij} u_j + c_i`. -/
def linDrift (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) (i : Fin d) : MvPolynomial (Fin d) ℂ :=
  ∑ j, ((A i j : ℝ) : ℂ) • X j + C ((c i : ℝ) : ℂ)

/-- The Weyl-ordered Koopman–von Neumann generator `½ Σ_i (π_i F_i + F_i π_i)` of the affine
drift (the same formula as `NsKoopman.kvnPoly`). -/
def linKvnPoly (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) : Module.End ℂ (MvPolynomial (Fin d) ℂ) :=
  ∑ i, weylProd (momOp i) (mulOp (linDrift A c i))





















/-- The affine-drift generator on the Gauss–polynomial core. -/
def linKoopmanOp (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype.comp ((coreRepPoly d).op (linKvnPoly A c))















/-! ## 2. The Stokes system: the mainstream operator itself -/

/-- The Stokes matrix `−ν λ_i δ_{ij}`. -/
def stokesMat (S : NsSystem d) (i j : Fin d) : ℝ := if i = j then -(S.nu * S.lam i) else 0





/-! ## 3. The Oseen linearization about an arbitrary point -/

/-- The Jacobian of the mainstream drift at `ū`:
`DF(ū)_{ij} = −ν λ_i δ_{ij} + Σ_k (b_{ijk} + b_{ikj}) ū_k`. -/
def oseenMat (S : NsSystem d) (ubar : Fin d → ℝ) (i j : Fin d) : ℝ :=
  stokesMat S i j + ∑ k, (S.bcoef i j k + S.bcoef i k j) * ubar k

/-- The constant of the first-order Taylor polynomial: `F(ū) − DF(ū) ū = −B(ū, ū)`. -/
def oseenConst (S : NsSystem d) (ubar : Fin d → ℝ) (i : Fin d) : ℝ :=
  -(∑ j, ∑ k, S.bcoef i j k * ubar j * ubar k)

/-- The mainstream drift at a real point. -/
def driftAt (S : NsSystem d) (u : Fin d → ℝ) (i : Fin d) : ℝ :=
  -(S.nu * S.lam i) * u i + ∑ j, ∑ k, S.bcoef i j k * u j * u k

/-- The affine drift evaluated at a real point. -/
def linDriftAt (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) (u : Fin d → ℝ) (i : Fin d) : ℝ :=
  ∑ j, A i j * u j + c i







end

end BookProof.NsLinearKoopmanEsa
