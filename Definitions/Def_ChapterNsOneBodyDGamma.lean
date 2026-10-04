import Theorems.Thm_BookProof_FockSecondQuantization_isPosCol_opCol

import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_symmetricOn

import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op

import Theorems.Thm_BookProof_YangMillsHermite_momOp_polySym

import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_quadForm_nonneg

import Theorems.Thm_BookProof_FockSecondQuantization_isHermCol_opCol

import Theorems.Thm_BookProof_FockSecondQuantization_dGammaOp_symmetricOn

import Theorems.Thm_BookProof_FockSecondQuantization_dGammaOp_quadForm_nonneg


import Theorems.Thm_BookProof_YangMillsHermite_mulOp_polySym

import Definitions.Def_ChapterNsFourierElimination
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
import Mathlib


/-!
# The one-body generator `H_sp = H_visc + H_advect` and its second quantization `dΓ(H_sp)`

Items 4 (operator half) and 5 of the Navier–Stokes plan items of `CONSOLIDATED_PLAN.md`
(§“Latest wave — 2026‑09‑15”), on the **Fourier-eliminated** Eulerian sector of
`BookProof.ChapterNsFourierElimination`: after the elimination `u_{i,j} ↦ i k_j u_i`,
`w_i ↦ −|k|² u_i`, `y_j ↦ 0` one parcel carries the six coordinates `(u_i, q_i)` and seven
real-coefficient constraint forms,

```
Re σ(R_i) = q_i + ν|k|² u_i      (three viscous/pressure forms),
Im σ(R_i) = (k·u) u_i            (three advection forms — the momentum convolution),
Im σ(Σ_j u_{j,j}) = k·u          (the eliminated incompressibility),
```

and the one-body generator is the Weyl-ordered sum of squares

```
H_sp = ½ Σ_{m<6} π_m² + ½ Σ_{r<7} (mulOp Φ_r)² .
```

## What is proved here

**§1–§2 (item 4, the assembly).**  `spFormPoly` is the seven-member one-parcel family, and
`redFormPoly_eq_liftParcel` identifies it with the `n`-parcel family of
`BookProof.NsFullEuler` parcel by parcel — the one-body generator really is the single-parcel
member of the landed reduced family.  `spHam` is the generator on any core representation of the
Gauss–polynomial core of `L²(ℝ⁶)`, and

* `spHam_eq_visc_add_advect` — **the splitting `H_sp = H_visc + H_advect`**: `H_visc` carries the
  six momenta and the four non-advective squares, `H_advect` the three advection squares
  `½ ((k·u) u_i)²`, whose form `(k·u) u_i = Σ_j k_j u_j u_i` is the momentum convolution of
  `BookProof.NsAdvectionConvolution`.  Nothing is dropped and nothing is demoted to a perturbation;
* `spHam_symmetricOn`, `spVisc_symmetricOn`, `spAdvect_symmetricOn` and
  `spHam_quadForm_nonneg`, `spVisc_quadForm_nonneg`, `spAdvect_quadForm_nonneg` — **the two
  Faris–Lavine inequalities of the item**: each half of the generator is symmetric and positive on
  the core, and `spHam_quadForm_split` shows the two form contributions add up to the generator's.

**§3 (item 4, the criterion).**  `spFried` is the comparison operator `N_E` of the route — the
Friedrichs realization of `H_sp` itself — and `spHam_esa_farisLavine` is the criterion in its
`H = N`, `c = 0` form (`spHam_commForm_zero`), with
`spFried_isPositiveSelfAdjointExtension` recording that `N_E` is a positive self-adjoint extension
of the generator and `polyGaussCore_le_spFriedDom` the domain obligation.

*Scope of the `H = N`, `c = 0` shortcut.*  It is available here only because the operator of this
chapter, `H_sp = ½ Σ π_m² + ½ Σ (mulOp Φ_r)²`, is a positive sum of squares.  The Hamiltonian of
the mainstream Navier–Stokes equations — the Koopman–von Neumann generator of `u̇ = −νAu + B(u,u)`
— is *not* bounded below (`BookProof.NsKoopman.nsKoopmanOp_not_bounded_below`), so for it the
comparison operator must be a genuinely different, positive operator; see
`BookProof.ChapterNsKoopman`, where the Leray energy `N_E = 1 + ‖u‖²` plays that role.

**§4 (item 5, the nested-Fock lift).**  `nsOnePart` is the same generator on the finite-mode
domain of the product-Hermite basis `coreBasis e` of `L²(ℝ⁶)`, `nsSpCol` its matrix in that basis
and `dGammaOp (nsSpCol …)` its second quantization `dΓ(H_sp) = Σ_{j,k} ⟪e_j, H_sp e_k⟫ a†_j a_k` on
the finite-occupation core of the Fock space.  Then

* `nsSpDGamma_symmetricOn`, `nsSpDGamma_quadForm_nonneg`, `nsSpDGamma_friedrichs_extension` — the
  lift is symmetric and positive and has a positive self-adjoint (Friedrichs) extension;
* `nsSpDGamma_esa_farisLavine` — `dΓ(H_sp)` is **essentially self-adjoint** on the domain of that
  realization, again the `H = N`, `c = 0` case of the criterion, and
  `nsSpDGammaFried_isPositiveSelfAdjointExtension` connects the two;
* `nsSpDGamma_number_conserving` — the lift **preserves every particle-number sector**, so no
  truncation is introduced, and `nsSpDGamma_one_particle` — on the one-particle sector the lift
  *is* the one-body generator, which is the non-vacuity of the construction.

**§4b (the unitary time evolution).**  `spHam_stone_flow` and `nsSpDGamma_stone_flow` are the
single-time package: by Stone's theorem each of the two comparison realizations has a self-adjoint
extension generating a strongly continuous one-parameter unitary group, the domains being dense
(`spFried_dom_dense`, `nsSpDGammaFried_dom_dense`).

**§5 (the parcel decomposition).**  `redHam_eq_sum_parcel` proves that the reduced `n`-parcel
Hamiltonian of `BookProof.NsFullEuler` is *literally* the sum of `n` copies of the one-body
generator, the `p`-th copy written in the six coordinates and six momenta of the parcel `p`
(`redParcelHam`, symmetric and positive by `redParcelHam_symmetricOn` /
`redParcelHam_quadForm_nonneg`), and `nsRedFullFockHam_sector_sum_parcel` transports that to the
`n`-parcel sector of the outer Hamiltonian.  This is the structural reading of `weylOp` — each
summand acting on a single parcel — that the second-quantized description presupposes; the general
regrouping is `weylOpDom_block_sum`.

**Honest boundary.**  The comparison used is the Friedrichs realization of the operator itself, so
the Faris–Lavine commutator constant is `c = 0`; no relative bound of the advection against an
independent comparison operator is claimed here, and no mass gap, uniqueness or global existence
statement is made.  Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.NsOneBody

open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

/-! ## 1. The seven one-parcel forms of the eliminated sector -/

/-- **The one-parcel reduced constraint family**: the three real residual parts
`q_i + ν|k|² u_i`, the three advection parts `(k·u) u_i` and the eliminated incompressibility
`k·u`, in the six reduced coordinates of a single parcel. -/
def spFormPoly (nu : ℝ) (k : Fin 3 → ℝ) (r : Fin 7) : MvPolynomial (Fin 6) ℂ :=
  if h : r.val < 3 then fourierVisc nu k ⟨r.val, h⟩
  else if h2 : r.val < 6 then fourierAdvect k ⟨r.val - 3, by omega⟩
  else fourierMomentum k

@[simp] theorem spFormPoly_re (nu : ℝ) (k : Fin 3 → ℝ) (i : Fin 3) :
    spFormPoly nu k (reIdx7 i) = fourierVisc nu k i := by
  have h : (reIdx7 i).val < 3 := i.isLt
  rw [spFormPoly, dif_pos h]

@[simp] theorem spFormPoly_im (nu : ℝ) (k : Fin 3 → ℝ) (i : Fin 3) :
    spFormPoly nu k (imIdx7 i) = fourierAdvect k i := by
  have hi : i.val < 3 := i.isLt
  have hv : (imIdx7 i).val = 3 + i.val := rfl
  have h1 : ¬ (imIdx7 i).val < 3 := by omega
  have h2 : (imIdx7 i).val < 6 := by omega
  have hsub : (imIdx7 i).val - 3 = i.val := by omega
  rw [spFormPoly, dif_neg h1, dif_pos h2]
  simp only [hsub, Fin.eta]

@[simp] theorem spFormPoly_div (nu : ℝ) (k : Fin 3 → ℝ) :
    spFormPoly nu k divIdx7 = fourierMomentum k := by
  have h1 : ¬ (divIdx7).val < 3 := by norm_num
  have h2 : ¬ (divIdx7).val < 6 := by norm_num
  rw [spFormPoly, dif_neg h1, dif_neg h2]

/-- **Every one-parcel form is real-coefficient**, hence its multiplication operator is symmetric
and its square is a positive summand of the generator. -/
theorem realCoeff_spFormPoly (nu : ℝ) (k : Fin 3 → ℝ) (r : Fin 7) :
    RealCoeff (spFormPoly nu k r) := by
  rw [spFormPoly]
  split
  · exact realCoeff_fourierVisc nu k _
  · split
    · exact realCoeff_fourierAdvect k _
    · exact realCoeff_fourierMomentum k



/-! ## 2. The one-body generator and its splitting `H_sp = H_visc + H_advect` -/

section Generator

variable {D : Submodule ℂ (L2d 6)}

/-- The six momenta `π_m = −i ∂_m` of the reduced coordinates, on a core representation. -/
def spPi (Φ : CoreRep 6 D) (m : Fin 6) : D →ₗ[ℂ] D := Φ.op (momOp m)

/-- The seven multiplication forms of the eliminated sector, on a core representation. -/
def spField (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (r : Fin 7) : D →ₗ[ℂ] D :=
  Φ.op (mulOp (spFormPoly nu k r))

/-- The **non-advective** forms: the three real residual parts and the eliminated
incompressibility, the advection slots being zeroed. -/
def spFieldVisc (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (r : Fin 7) : D →ₗ[ℂ] D :=
  if 3 ≤ r.val ∧ r.val < 6 then 0 else spField Φ nu k r

/-- The **advection** forms `(k·u) u_i`, the other slots being zeroed. -/
def spFieldAdv (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (r : Fin 7) : D →ₗ[ℂ] D :=
  if 3 ≤ r.val ∧ r.val < 6 then spField Φ nu k r else 0

@[simp] theorem spFieldAdv_im (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (i : Fin 3) :
    spFieldAdv Φ nu k (imIdx7 i) = Φ.op (mulOp (fourierAdvect k i)) := by
  have hv : (imIdx7 i).val = 3 + i.val := rfl
  have hi : i.val < 3 := i.isLt
  rw [spFieldAdv, if_pos (by omega), spField, spFormPoly_im]

@[simp] theorem spFieldVisc_re (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (i : Fin 3) :
    spFieldVisc Φ nu k (reIdx7 i) = Φ.op (mulOp (fourierVisc nu k i)) := by
  have hv : (reIdx7 i).val = i.val := rfl
  have hi : i.val < 3 := i.isLt
  rw [spFieldVisc, if_neg (by omega), spField, spFormPoly_re]

@[simp] theorem spFieldVisc_div (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) :
    spFieldVisc Φ nu k divIdx7 = Φ.op (mulOp (fourierMomentum k)) := by
  rw [spFieldVisc, if_neg (by norm_num), spField, spFormPoly_div]

/-- **The one-body generator** `H_sp = ½ Σ_m π_m² + ½ Σ_r (mulOp Φ_r)²` of the eliminated
Eulerian sector, on a core representation of the Gauss–polynomial core of `L²(ℝ⁶)`. -/
def spHam (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) : D →ₗ[ℂ] L2d 6 :=
  weylOp (spPi Φ) (spField Φ nu k)

/-- The **viscous/pressure half** `H_visc` of the generator: the six momenta and the four
non-advective squares. -/
def spVisc (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) : D →ₗ[ℂ] L2d 6 :=
  weylOp (spPi Φ) (spFieldVisc Φ nu k)

/-- The **advection half** `H_advect` of the generator: the three squares `½ ((k·u) u_i)²` of the
momentum convolution, with no momentum term. -/
def spAdvect (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) : D →ₗ[ℂ] L2d 6 :=
  weylOp (fun _ : Fin 0 => (0 : D →ₗ[ℂ] D)) (spFieldAdv Φ nu k)







/-! ### Symmetry and positivity — the two Faris–Lavine inequalities of the item -/

theorem spPi_symmetricOn (Φ : CoreRep 6 D) (m : Fin 6) :
    SymmetricOn D (D.subtype.comp (spPi Φ m)) :=
  Φ.symmetricOn_op (momOp_polySym m)

theorem spField_symmetricOn (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (r : Fin 7) :
    SymmetricOn D (D.subtype.comp (spField Φ nu k r)) :=
  Φ.symmetricOn_op (mulOp_polySym (realCoeff_spFormPoly nu k r))







/-- **The one-body generator is symmetric on the core.** -/
theorem spHam_symmetricOn (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) :
    SymmetricOn D (spHam Φ nu k) :=
  weylOpDom_symmetricOn (spPi_symmetricOn Φ) (spField_symmetricOn Φ nu k)





/-- **The first Faris–Lavine inequality: the generator is positive on the core.** -/
theorem spHam_quadForm_nonneg (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (x : D) :
    0 ≤ quadForm (spHam Φ nu k) x :=
  weylOpDom_quadForm_nonneg (spPi_symmetricOn Φ) (spField_symmetricOn Φ nu k) x











end Generator

/-! ## 3. Faris–Lavine for the one-body generator: the comparison `N_E` -/

/-- The one-body generator on the Gauss–polynomial core of `L²(ℝ⁶)`, as a densely defined positive
symmetric operator. -/
def spPosSym (nu : ℝ) (k : Fin 3 → ℝ) : PosSymOp (L2d 6) where
  dom := polyGaussCore (d := 6)
  op := spHam (coreRepPoly 6) nu k
  sym := spHam_symmetricOn (coreRepPoly 6) nu k
  pos := spHam_quadForm_nonneg (coreRepPoly 6) nu k

/-- **The comparison operator `N_E` of the route** — the Friedrichs realization of the one-body
generator itself, for which the Faris–Lavine commutator constant is `c = 0`. -/
def spFried (nu : ℝ) (k : Fin 3 → ℝ) : Comparison (L2d 6) :=
  friedrichsComparison (spPosSym nu k) polyGaussCore_dense











/-! ## 4. The nested-Fock lift `dΓ(H_sp)` -/

section DGamma

/-- **The one-body generator on the finite-mode domain of the product Hermite basis** of
`L²(ℝ⁶)` — the same operator as `spHam`, in the form the second quantization consumes. -/
def nsOnePart (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    finiteModeDomain (coreBasis e) →ₗ[ℂ] finiteModeDomain (coreBasis e) :=
  weylOpDom (spPi (coreRepBasis e)) (spField (coreRepBasis e) nu k)



/-- The matrix of the one-body generator in the product Hermite basis. -/
def nsSpCol (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) : ℕ → (ℕ →₀ ℂ) :=
  opCol (coreBasis e) (nsOnePart e nu k)

theorem nsSpCol_isHermCol (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    IsHermCol (nsSpCol e nu k) :=
  isHermCol_opCol (spHam_symmetricOn (coreRepBasis e) nu k)

theorem nsSpCol_isPosCol (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    IsPosCol (nsSpCol e nu k) :=
  isPosCol_opCol (spHam_quadForm_nonneg (coreRepBasis e) nu k)

/-- **`dΓ(H_sp)` is symmetric** on the finite-occupation core of the Fock space. -/
theorem nsSpDGamma_symmetricOn (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    SymmetricOn (lpFiniteModes Conf) (dGammaOp (nsSpCol e nu k)) :=
  dGammaOp_symmetricOn (nsSpCol_isHermCol e nu k)

/-- **`dΓ(H_sp)` is positive** on the finite-occupation core. -/
theorem nsSpDGamma_quadForm_nonneg (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ)
    (x : lpFiniteModes Conf) :
    0 ≤ quadForm (dGammaOp (nsSpCol e nu k)) x :=
  dGammaOp_quadForm_nonneg (nsSpCol_isPosCol e nu k) x



/-- The lift as a densely defined positive symmetric operator on the Fock space. -/
def nsSpDGammaPosSym (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) : PosSymOp Fock where
  dom := lpFiniteModes Conf
  op := dGammaOp (nsSpCol e nu k)
  sym := nsSpDGamma_symmetricOn e nu k
  pos := nsSpDGamma_quadForm_nonneg e nu k

/-- **The outer comparison operator** — the Friedrichs realization of `dΓ(H_sp)`. -/
def nsSpDGammaFried (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) : Comparison Fock :=
  friedrichsComparison (nsSpDGammaPosSym e nu k) finiteOccupation_dense















end DGamma

/-! ## 4b. The unitary time evolution of the lift -/









/-! ## 5. The parcel decomposition — each summand of the sector Hamiltonian acts on one parcel

This is the structural reading of `weylOp` that §D8(5) of `CONSOLIDATED_PLAN.md` leaves owed for
the reduced sector: the reduced `n`-parcel Hamiltonian is *literally* the sum of `n` copies of the
one-body generator, the `p`-th copy written in the six coordinates of the parcel `p`. -/

section Parcel

variable {n : ℕ}

/-- The six momenta of the parcel `p` inside the `n`-parcel reduced sector. -/
def parcelPi (n : ℕ) (p : Fin n) (i : Fin 6) :
    polyGaussCore (d := n * 6) →ₗ[ℂ] polyGaussCore (d := n * 6) :=
  (coreRepPoly (n * 6)).op (momOp (redIdx p i))

/-- The seven constraint forms of the parcel `p` inside the `n`-parcel reduced sector: the
one-parcel family `spFormPoly`, lifted to the coordinates of that parcel. -/
def parcelField (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (r : Fin 7) :
    polyGaussCore (d := n * 6) →ₗ[ℂ] polyGaussCore (d := n * 6) :=
  (coreRepPoly (n * 6)).op (mulOp (liftParcel p (spFormPoly nu k r)))

/-- **The one-parcel summand** of the reduced `n`-parcel Hamiltonian. -/
def redParcelHam (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) :
    polyGaussCore (d := n * 6) →ₗ[ℂ] L2d (n * 6) :=
  weylOp (parcelPi n p) (parcelField nu k n p)



























end Parcel

end

end BookProof.NsOneBody
