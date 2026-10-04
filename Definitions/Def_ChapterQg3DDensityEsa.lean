import Definitions.Def_ChapterQg3DCrossTermEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterYangMillsHermite
import Mathlib


/-!
# The 3D gravity Hamiltonian **with its density dependence**: the `1/e` kinetic
coefficient, the `√e` of the densitized momenta and the polynomial `e` in front of the
bracket (QG-3.2(b), frozen-density and background-fibred forms)

`BookProof.Qg3DCrossTermEsa` proved essential self-adjointness of the book's 3D density
(`book.tex`, around line 8190)

`ℋ = (1/(16e)) 𝒮^{ab}𝒮_{ab} − (1/(24e)) 𝒫² + ½ 𝒮^{ab}E_{ab} + ⅓ 𝒫 E_a{}^a − e(…)`

**at the flat density** `e = 1`, `χ = δ` only.  This module restores the three places where
the density enters, together with the inverse tetrad `χ` in the definitions of `𝒮` and `𝒫`:

`𝒫 = η_{ab} χ^a{}_{a₁} χ^b{}_{a₂} p^{a₁a₂}`,
`𝒮^{ab} = χ^a{}_{a₁} χ^b{}_{a₂} (p^{a₁a₂} + p^{a₂a₁} − ⅔ η^{a₁a₂} 𝒫)`.

## What is proved

* `momCalP`, `momCalS` — `𝒫` and `𝒮^{ab}` as coefficient vectors in the `84` momenta, for an
  **arbitrary real** inverse tetrad `χ`; `momCalP_flat`, `momCalS_flat`, `densCross_flat` —
  at `χ = δ` they are the flat vectors of `Qg3DCrossTermEsa` (so the flat result is the
  special case `e = 1`, `χ = δ`).
* `kinOf S P c` — the kinetic matrix `c · ((1/16) Σ 𝒮^{ab}𝒮_{ab} − (1/24) 𝒫²)` of arbitrary
  momentum vectors; `crossOf S P` — the Weyl-ordered cross matrix of `½ 𝒮·E + ⅓ 𝒫·E`.
* `qg3DDensityHam e χ Qb` — the book's density at density `e` and inverse tetrad `χ`:
  kinetic coefficient `1/e`, cross terms `½ 𝒮·E + ⅓ 𝒫·E`, bracket `−e · Qb` (an arbitrary
  real quadratic form in the coordinates).  **`qg3DDensity_esa`**: essentially self-adjoint
  on the Gauss–polynomial core for **every** real `e`, `χ` and `Qb`; `qg3DDensity_stone_flow`,
  `qg3DDensity_dGamma_esa`, `qg3DDensity_dGammaOp_esa` (the enclosures).
* **The densitized form** (`y = √e`, `𝒮 = y 𝒮̃`, `𝒫 = y 𝒫̃`): `qg3DDensitizedHam y S̃ P̃ Qb` has
  the *constant* kinetic coefficient `1`, the cross terms multiplied by `y`, and the bracket
  multiplied by `y² = e`.  **`kinOf_absorption`** — `(1/e)(y𝒮̃)² = 𝒮̃²` at matrix level (the
  operator form of `QuantumGravityDensitized.kinetic_absorption`);
  **`qg3DDensitized_eq_density`** — for `y ≠ 0` the densitized operator *is* the physical one
  at `e = y²` with `𝒮 = y𝒮̃`; **`qg3DDensitized_esa`** — it is essentially self-adjoint for
  **every** real `y`, including the degenerate tetrad `y = 0`, where the physical `1/e` form is
  undefined.
* **The density as a function of the background tetrad.**  `qgFibredDensityHam bg Qb` is the
  orthogonal direct sum, over an *arbitrary* family `bg : ι → Matrix (Fin 4) (Fin 4) ℝ` of
  background tetrads, of the operators at density `e = det (bg i)` and inverse tetrad
  `χ = (bg i)⁻¹`.  **`qgFibredDensity_esa`** — essentially self-adjoint, with no uniformity in
  the fibre: the density `det` (a degree-four polynomial of the tetrad,
  `det_smul_background`) may approach `0`, so that `1/e` is unbounded over the family.

## Honest boundary

* The density is **frozen** in each operator (a constant, or a fibre label with no conjugate
  momentum of its own).  The operator in which `e = det e_b{}^a` is itself a function of the
  canonical tetrad coordinates — so that `1/e` and `e` are multiplication operators that do
  not commute with the momenta, the kinetic term needs an ordering, and the bracket becomes
  a sextic indefinite potential — is **not** covered: it is not a quadratic Hamiltonian, and
  none of the ESA instruments of the project applies to a hyperbolic kinetic term with an
  indefinite polynomial potential.
* The bracket `(…)` is an arbitrary real matrix `Qb`, not written index by index.  The index
  conventions for `p^{ab}` and `E_{ab}` are those of `Qg3DCrossTermEsa`; since the theorems
  hold for every real `χ`, `Qb` and every momentum-vector family, they do not depend on them.
* No gap, no spectrum, no continuum limit is claimed; QG-3.2(a) is untouched.
-/

namespace BookProof.Qg3DDensityEsa

open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

/-! ## 1. `𝒫` and `𝒮^{ab}` with an arbitrary inverse tetrad -/

/-- The Kronecker delta, the inverse tetrad of the flat background. -/
def flatChi (a b : Fin 4) : ℝ := if a = b then 1 else 0

/-- `𝒫 = η_{ab} χ^a{}_{a₁} χ^b{}_{a₂} p^{a₁a₂}` as a coefficient vector in the momenta. -/
def momCalP (chi : Fin 4 → Fin 4 → ℝ) (j : Fin 84) : ℝ :=
  ∑ a : Fin 4, ∑ a₁ : Fin 4, ∑ a₂ : Fin 4, qgEta a * chi a a₁ * chi a a₂ * pVec a₁ a₂ j

/-- `𝒮^{ab} = χ^a{}_{a₁} χ^b{}_{a₂} (p^{a₁a₂} + p^{a₂a₁} − ⅔ η^{a₁a₂} 𝒫)`. -/
def momCalS (chi : Fin 4 → Fin 4 → ℝ) (a b : Fin 4) (j : Fin 84) : ℝ :=
  ∑ a₁ : Fin 4, ∑ a₂ : Fin 4, chi a a₁ * chi b a₂ *
    (pVec a₁ a₂ j + pVec a₂ a₁ j - 2 / 3 * (if a₁ = a₂ then qgEta a₁ else 0) * momCalP chi j)





/-! ## 2. Kinetic and cross matrices of arbitrary momentum vectors -/

/-- The kinetic matrix `c · ((1/16) 𝒮^{ab}𝒮_{ab} − (1/24) 𝒫²)` (indices lowered with `η`). -/
def kinOf (S : Fin 4 → Fin 4 → Fin 84 → ℝ) (P : Fin 84 → ℝ) (c : ℝ) (j k : Fin 84) : ℝ :=
  c * ((1 / 16) * ∑ a : Fin 4, ∑ b : Fin 4, qgEta a * qgEta b * S a b j * S a b k
    - (1 / 24) * P j * P k)

/-- The Weyl-ordered cross matrix of `½ 𝒮^{ab}E_{ab} + ⅓ 𝒫 E_a{}^a`. -/
def crossOf (S : Fin 4 → Fin 4 → Fin 84 → ℝ) (P : Fin 84 → ℝ) (i j : Fin 84) : ℝ :=
  ∑ a : Fin 4, ∑ b : Fin 4, (1 / 2) * S a b j * eVec a b i + 1 / 3 * P j * eTrVec i







/-! ## 3. The Hamiltonian at density `e` and inverse tetrad `χ` -/

/-- **The book's 3D density at density `e` and inverse tetrad `χ`**:
`(1/(16e)) 𝒮^{ab}𝒮_{ab} − (1/(24e)) 𝒫² + ½ 𝒮^{ab}E_{ab} + ⅓ 𝒫 E_a{}^a − e · Qb`, Weyl ordered,
with an arbitrary real quadratic bracket `Qb`. -/
def qg3DDensityHam (e : ℝ) (chi : Fin 4 → Fin 4 → ℝ) (Qb : Fin 84 → Fin 84 → ℝ) :
    (polyGaussCore (d := 84)) →ₗ[ℂ] L2d 84 :=
  fqOp (kinOf (momCalS chi) (momCalP chi) (1 / e)) ((-e) • Qb)
    (crossOf (momCalS chi) (momCalP chi)) 0 0













/-! ## 4. The densitized form: `y = √e`, `𝒮 = y𝒮̃` -/

/-- **The densitized Hamiltonian**: constant kinetic coefficient, cross terms multiplied by
`y`, bracket multiplied by `y² = e`; `S̃`, `P̃` are the densitized momentum vectors. -/
def qg3DDensitizedHam (y : ℝ) (St : Fin 4 → Fin 4 → Fin 84 → ℝ) (Pt : Fin 84 → ℝ)
    (Qb : Fin 84 → Fin 84 → ℝ) : (polyGaussCore (d := 84)) →ₗ[ℂ] L2d 84 :=
  fqOp (kinOf St Pt 1) ((-(y ^ 2)) • Qb) (y • crossOf St Pt) 0 0







/-! ## 5. The density as a function of the background tetrad -/





/-- **The background-fibred gravity Hamiltonian**: the orthogonal direct sum, over an
arbitrary family of background tetrads `bg i`, of the density-dependent operators at density
`e = det (bg i)` and inverse tetrad `χ = (bg i)⁻¹`, with fibrewise brackets `Qb i`. -/
def qgFibredDensityHam {ι : Type*} (bg : ι → Matrix (Fin 4) (Fin 4) ℝ)
    (Qb : ι → Fin 84 → Fin 84 → ℝ) :
    dsCore (fun _ : ι => (polyGaussCore (d := 84))) →ₗ[ℂ] lp (fun _ : ι => L2d 84) 2 :=
  dsOp (fun i => qg3DDensityHam (bg i).det (fun a b => (bg i)⁻¹ a b) (Qb i))









end

end BookProof.Qg3DDensityEsa
