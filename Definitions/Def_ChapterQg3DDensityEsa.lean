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
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsNonAbelianEsa
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
open BookProof.Qg3DCrossTermEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa BookProof.FockSecondQuantization BookProof.QuadFockEsa

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

theorem momCalP_flat (j : Fin 84) : momCalP flatChi j = calPVec j := by
  simp only [momCalP, calPVec, flatChi, Fin.sum_univ_four, Fin.isValue, ↓reduceIte,
    Fin.reduceEq]
  ring

theorem momCalS_flat (a b : Fin 4) (j : Fin 84) : momCalS flatChi a b j = calSVec a b j := by
  have hP := momCalP_flat j
  fin_cases a <;> fin_cases b <;>
    simp only [momCalS, calSVec, flatChi, hP, Fin.sum_univ_four, Fin.isValue, ↓reduceIte,
      Fin.reduceEq, Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk] <;> ring

/-! ## 2. Kinetic and cross matrices of arbitrary momentum vectors -/

/-- The kinetic matrix `c · ((1/16) 𝒮^{ab}𝒮_{ab} − (1/24) 𝒫²)` (indices lowered with `η`). -/
def kinOf (S : Fin 4 → Fin 4 → Fin 84 → ℝ) (P : Fin 84 → ℝ) (c : ℝ) (j k : Fin 84) : ℝ :=
  c * ((1 / 16) * ∑ a : Fin 4, ∑ b : Fin 4, qgEta a * qgEta b * S a b j * S a b k
    - (1 / 24) * P j * P k)

/-- The Weyl-ordered cross matrix of `½ 𝒮^{ab}E_{ab} + ⅓ 𝒫 E_a{}^a`. -/
def crossOf (S : Fin 4 → Fin 4 → Fin 84 → ℝ) (P : Fin 84 → ℝ) (i j : Fin 84) : ℝ :=
  ∑ a : Fin 4, ∑ b : Fin 4, (1 / 2) * S a b j * eVec a b i + 1 / 3 * P j * eTrVec i

/-- At the flat background the cross matrix is the one of `Qg3DCrossTermEsa`. -/
theorem densCross_flat : crossOf (momCalS flatChi) (momCalP flatChi) = bookCrossMat := by
  funext i j
  simp only [crossOf, bookCrossMat, momCalS_flat, momCalP_flat]

/-- **Kinetic absorption at matrix level**: `(1/e)(y𝒮̃)² = 𝒮̃²` when `e = y²`, `y ≠ 0`. -/
theorem kinOf_absorption (S : Fin 4 → Fin 4 → Fin 84 → ℝ) (P : Fin 84 → ℝ) {y : ℝ}
    (hy : y ≠ 0) :
    kinOf (fun a b j => y * S a b j) (fun j => y * P j) (1 / y ^ 2) = kinOf S P 1 := by
  funext j k
  simp only [kinOf]
  have h1 : ∀ a b : Fin 4, qgEta a * qgEta b * (y * S a b j) * (y * S a b k)
      = y ^ 2 * (qgEta a * qgEta b * S a b j * S a b k) := fun a b => by ring
  simp only [h1, ← Finset.mul_sum]
  field_simp

/-- The cross matrix is linear in the momentum vectors: `𝒮 = y𝒮̃` scales it by `y`. -/
theorem crossOf_smul (S : Fin 4 → Fin 4 → Fin 84 → ℝ) (P : Fin 84 → ℝ) (y : ℝ) :
    crossOf (fun a b j => y * S a b j) (fun j => y * P j) = y • crossOf S P := by
  funext i j
  simp only [crossOf, Pi.smul_apply, smul_eq_mul, mul_add, Finset.mul_sum]
  congr 1
  · exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
  · ring

/-! ## 3. The Hamiltonian at density `e` and inverse tetrad `χ` -/

/-- **The book's 3D density at density `e` and inverse tetrad `χ`**:
`(1/(16e)) 𝒮^{ab}𝒮_{ab} − (1/(24e)) 𝒫² + ½ 𝒮^{ab}E_{ab} + ⅓ 𝒫 E_a{}^a − e · Qb`, Weyl ordered,
with an arbitrary real quadratic bracket `Qb`. -/
def qg3DDensityHam (e : ℝ) (chi : Fin 4 → Fin 4 → ℝ) (Qb : Fin 84 → Fin 84 → ℝ) :
    (polyGaussCore (d := 84)) →ₗ[ℂ] L2d 84 :=
  fqOp (kinOf (momCalS chi) (momCalP chi) (1 / e)) ((-e) • Qb)
    (crossOf (momCalS chi) (momCalP chi)) 0 0

/-- **ESA at every density.**  For every real density `e`, every real inverse tetrad `χ` and
every real bracket `Qb`, the gravity Hamiltonian is essentially self-adjoint on the core. -/
theorem qg3DDensity_esa (e : ℝ) (chi : Fin 4 → Fin 4 → ℝ) (Qb : Fin 84 → Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 84)) (qg3DDensityHam e chi Qb) :=
  fqOp_essentiallySelfAdjoint _ _ _ _ _

theorem qg3DDensity_symmetricOn (e : ℝ) (chi : Fin 4 → Fin 4 → ℝ) (Qb : Fin 84 → Fin 84 → ℝ) :
    SymmetricOn (polyGaussCore (d := 84)) (qg3DDensityHam e chi Qb) :=
  fqOp_symmetric _ _ _ _ _

/-- The unitary group of the gravity Hamiltonian at density `e` (Stone). -/
theorem qg3DDensity_stone_flow (e : ℝ) (chi : Fin 4 → Fin 4 → ℝ) (Qb : Fin 84 → Fin 84 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d 84)) (U : ℝ → (L2d 84 →L[ℂ] L2d 84)),
      IsSelfAdjointExtension (qg3DDensityHam e chi Qb) T.op ∧ IsStoneFlow T U :=
  fqOp_stone_flow _ _ _ _ _

/-- The enclosure `dΓ(h)` of the density-dependent gravity Hamiltonian is essentially
self-adjoint on the finite-particle domain. -/
theorem qg3DDensity_dGamma_esa (e : ℝ) (chi : Fin 4 → Fin 4 → ℝ) (Qb : Fin 84 → Fin 84 → ℝ) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore (L2dSpace 84) (polyGaussCore (d := 84))
        (polyGaussCore (d := 84)) n))
      (dGammaCoreOp (L2dSpace 84) (polyGaussCore (d := 84))
        (qg3DDensityHam e chi Qb) (polyGaussCore (d := 84))) :=
  EsaOneParticle.dGamma_essentiallySelfAdjointOn_of_esa (Hs := L2dSpace 84)
    (qg3DDensityHam e chi Qb) polyGaussCore_dense (qg3DDensity_symmetricOn e chi Qb)
    (qg3DDensity_esa e chi Qb)

/-- The same in the occupation-number spelling on the finite-occupation core. -/
theorem qg3DDensity_dGammaOp_esa (en : ℕ ≃ (Fin 84 →₀ ℕ)) (e : ℝ) (chi : Fin 4 → Fin 4 → ℝ)
    (Qb : Fin 84 → Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (BookProof.NavierStokesFlow.lpFiniteModes Conf)
      (dGammaOp (hermCol en (fqPoly (kinOf (momCalS chi) (momCalP chi) (1 / e)) ((-e) • Qb)
        (crossOf (momCalS chi) (momCalP chi)) 0 0))) :=
  dGamma_fqPoly_essentiallySelfAdjointOn_core en _ _ _ _ _

/-- The flat case: at `e = 1`, `χ = δ` the cross matrix is `bookCrossMat`, the cross-term
matrix of `Qg3DCrossTermEsa.qg3DCrossHamiltonian`. -/
theorem qg3DDensity_flat (Qb : Fin 84 → Fin 84 → ℝ) :
    qg3DDensityHam 1 flatChi Qb
      = fqOp (kinOf calSVec calPVec 1) ((-1 : ℝ) • Qb) bookCrossMat 0 0 := by
  have hS : momCalS flatChi = calSVec := by
    funext a b j; exact momCalS_flat a b j
  have hP : momCalP flatChi = calPVec := by
    funext j; exact momCalP_flat j
  rw [qg3DDensityHam, ← densCross_flat, hS, hP]
  norm_num

/-! ## 4. The densitized form: `y = √e`, `𝒮 = y𝒮̃` -/

/-- **The densitized Hamiltonian**: constant kinetic coefficient, cross terms multiplied by
`y`, bracket multiplied by `y² = e`; `S̃`, `P̃` are the densitized momentum vectors. -/
def qg3DDensitizedHam (y : ℝ) (St : Fin 4 → Fin 4 → Fin 84 → ℝ) (Pt : Fin 84 → ℝ)
    (Qb : Fin 84 → Fin 84 → ℝ) : (polyGaussCore (d := 84)) →ₗ[ℂ] L2d 84 :=
  fqOp (kinOf St Pt 1) ((-(y ^ 2)) • Qb) (y • crossOf St Pt) 0 0

/-- **The densitized operator is the physical one**: for `y ≠ 0`, with `e = y²` and
`𝒮 = y𝒮̃`, `𝒫 = y𝒫̃`, the `1/e` kinetic term, the cross terms and the `e`-bracket of the
physical density are exactly those of the densitized operator. -/
theorem qg3DDensitized_eq_density {y : ℝ} (hy : y ≠ 0) (St : Fin 4 → Fin 4 → Fin 84 → ℝ)
    (Pt : Fin 84 → ℝ) (Qb : Fin 84 → Fin 84 → ℝ) :
    qg3DDensitizedHam y St Pt Qb
      = fqOp (kinOf (fun a b j => y * St a b j) (fun j => y * Pt j) (1 / y ^ 2))
          ((-(y ^ 2)) • Qb) (crossOf (fun a b j => y * St a b j) (fun j => y * Pt j)) 0 0 := by
  rw [qg3DDensitizedHam, kinOf_absorption St Pt hy, crossOf_smul]

/-- The physical operator at density `e = y²` and inverse tetrad `χ` is the densitized
operator with `𝒮̃ = 𝒮/y`, `𝒫̃ = 𝒫/y`. -/
theorem qg3DDensity_eq_densitized {y : ℝ} (hy : y ≠ 0) (chi : Fin 4 → Fin 4 → ℝ)
    (Qb : Fin 84 → Fin 84 → ℝ) :
    qg3DDensityHam (y ^ 2) chi Qb
      = qg3DDensitizedHam y (fun a b j => momCalS chi a b j / y) (fun j => momCalP chi j / y)
          Qb := by
  rw [qg3DDensitized_eq_density hy]
  have hS : (fun a b j => y * (momCalS chi a b j / y)) = momCalS chi := by
    funext a b j; field_simp
  have hP : (fun j => y * (momCalP chi j / y)) = momCalP chi := by
    funext j; field_simp
  rw [hS, hP, qg3DDensityHam]

/-- **ESA of the densitized operator for every `y`**, including the degenerate tetrad
`y = 0`, where the physical `1/e` form of the kinetic term is undefined. -/
theorem qg3DDensitized_esa (y : ℝ) (St : Fin 4 → Fin 4 → Fin 84 → ℝ) (Pt : Fin 84 → ℝ)
    (Qb : Fin 84 → Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 84)) (qg3DDensitizedHam y St Pt Qb) :=
  fqOp_essentiallySelfAdjoint _ _ _ _ _

/-! ## 5. The density as a function of the background tetrad -/

/-- The density of a scaled background: `det (c • ē) = c⁴ det ē` — the density is a
homogeneous polynomial of degree four in the tetrad. -/
theorem det_smul_background (c : ℝ) (eb : Matrix (Fin 4) (Fin 4) ℝ) :
    (c • eb).det = c ^ 4 * eb.det := by
  rw [Matrix.det_smul, Fintype.card_fin]

/-- The density takes every positive value along the scaled flat backgrounds, so `1/e` is
unbounded over the family of backgrounds. -/
theorem det_smul_one (c : ℝ) : (c • (1 : Matrix (Fin 4) (Fin 4) ℝ)).det = c ^ 4 := by
  rw [det_smul_background, Matrix.det_one, mul_one]

/-- **The background-fibred gravity Hamiltonian**: the orthogonal direct sum, over an
arbitrary family of background tetrads `bg i`, of the density-dependent operators at density
`e = det (bg i)` and inverse tetrad `χ = (bg i)⁻¹`, with fibrewise brackets `Qb i`. -/
def qgFibredDensityHam {ι : Type*} (bg : ι → Matrix (Fin 4) (Fin 4) ℝ)
    (Qb : ι → Fin 84 → Fin 84 → ℝ) :
    dsCore (fun _ : ι => (polyGaussCore (d := 84))) →ₗ[ℂ] lp (fun _ : ι => L2d 84) 2 :=
  dsOp (fun i => qg3DDensityHam (bg i).det (fun a b => (bg i)⁻¹ a b) (Qb i))

/-- **ESA of the background-fibred Hamiltonian**, for an arbitrary family of backgrounds and
brackets, with no uniformity: the density `det (bg i)` may approach `0` (so that `1/e` is
unbounded) or vanish. -/
theorem qgFibredDensity_esa {ι : Type*} (bg : ι → Matrix (Fin 4) (Fin 4) ℝ)
    (Qb : ι → Fin 84 → Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (dsCore (fun _ : ι => (polyGaussCore (d := 84))))
      (qgFibredDensityHam bg Qb) :=
  dsOp_essentiallySelfAdjointOn _ fun _ => qg3DDensity_esa _ _ _



/-- The fibred core is dense. -/
theorem qgFibredDensity_core_dense {ι : Type*} :
    Dense ((dsCore (fun _ : ι => (polyGaussCore (d := 84))) : Submodule ℂ _) :
      Set (lp (fun _ : ι => L2d 84) 2)) :=
  dsCore_dense fun _ => polyGaussCore_dense

/-- The concrete family of all backgrounds with positive density (the density genuinely
varies over the family, `det_smul_one`). -/
theorem qgFibredDensity_posDet_esa (Qb : {eb : Matrix (Fin 4) (Fin 4) ℝ // 0 < eb.det} →
    Fin 84 → Fin 84 → ℝ) :
    EssentiallySelfAdjointOn
      (dsCore (fun _ : {eb : Matrix (Fin 4) (Fin 4) ℝ // 0 < eb.det} =>
        (polyGaussCore (d := 84))))
      (qgFibredDensityHam (fun eb => eb.1) Qb) :=
  qgFibredDensity_esa _ _

end

end BookProof.Qg3DDensityEsa
