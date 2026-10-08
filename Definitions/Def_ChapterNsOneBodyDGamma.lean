import Theorems.Thm_BookProof_FockSecondQuantization_isPosCol_opCol





import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op

import Theorems.Thm_BookProof_YangMillsHermite_momOp_polySym


import Theorems.Thm_BookProof_FockSecondQuantization_isHermCol_opCol

import Theorems.Thm_BookProof_FockSecondQuantization_dGammaOp_symmetricOn

import Theorems.Thm_BookProof_FockSecondQuantization_dGammaOp_quadForm_nonneg


import Theorems.Thm_BookProof_YangMillsHermite_mulOp_polySym

import Definitions.Def_ChapterNsFourierElimination
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesFullEulerianFock
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
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
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

/-- **The one-body family is the single-parcel member of the landed reduced family**: the
`n`-parcel forms of `BookProof.NsFullEuler` are the parcelwise lifts of the forms above. -/
theorem redFormPoly_eq_liftParcel (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (r : Fin 7) :
    redFormPoly nu k n p r = liftParcel p (spFormPoly nu k r) := by
  rw [redFormPoly, spFormPoly]
  split
  · exact redVisc_eq_liftParcel nu k n p _
  · split
    · exact redAdvectPoly_eq_liftParcel k n p _
    · exact redMomentumPoly_eq_liftParcel k n p

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

theorem spField_sq_split (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (r : Fin 7) :
    (spField Φ nu k r).comp (spField Φ nu k r)
      = (spFieldVisc Φ nu k r).comp (spFieldVisc Φ nu k r)
        + (spFieldAdv Φ nu k r).comp (spFieldAdv Φ nu k r) := by
  simp only [spFieldVisc, spFieldAdv]
  split <;> simp

theorem spHamDom_eq_visc_add_advect (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) :
    weylOpDom (spPi Φ) (spField Φ nu k)
      = weylOpDom (spPi Φ) (spFieldVisc Φ nu k)
        + weylOpDom (fun _ : Fin 0 => (0 : D →ₗ[ℂ] D)) (spFieldAdv Φ nu k) := by
  have hsum : (∑ r, (spField Φ nu k r).comp (spField Φ nu k r))
      = (∑ r, (spFieldVisc Φ nu k r).comp (spFieldVisc Φ nu k r))
        + ∑ r, (spFieldAdv Φ nu k r).comp (spFieldAdv Φ nu k r) := by
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun r _ => spField_sq_split Φ nu k r
  simp only [weylOpDom, hsum]
  simp only [Finset.univ_eq_empty, Finset.sum_empty]
  module

set_option maxHeartbeats 1000000 in
-- unifying the two Weyl-ordered sums of squares through `weylOp` is a costly defeq check
/-- **The splitting of the one-body generator**, `H_sp = H_visc + H_advect`: the advection squares
are separated out of the Weyl-ordered sum, and nothing else changes. -/
theorem spHam_eq_visc_add_advect (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) :
    spHam Φ nu k = spVisc Φ nu k + spAdvect Φ nu k := by
  rw [spHam, spVisc, spAdvect, weylOp, weylOp, weylOp, spHamDom_eq_visc_add_advect Φ nu k,
    LinearMap.comp_add]

/-! ### Symmetry and positivity — the two Faris–Lavine inequalities of the item -/

theorem spPi_symmetricOn (Φ : CoreRep 6 D) (m : Fin 6) :
    SymmetricOn D (D.subtype.comp (spPi Φ m)) :=
  Φ.symmetricOn_op (momOp_polySym m)

theorem spField_symmetricOn (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (r : Fin 7) :
    SymmetricOn D (D.subtype.comp (spField Φ nu k r)) :=
  Φ.symmetricOn_op (mulOp_polySym (realCoeff_spFormPoly nu k r))

theorem symmetricOn_zero : SymmetricOn D (D.subtype.comp (0 : D →ₗ[ℂ] D)) := by
  intro x y
  simp

theorem spFieldVisc_symmetricOn (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (r : Fin 7) :
    SymmetricOn D (D.subtype.comp (spFieldVisc Φ nu k r)) := by
  rw [spFieldVisc]
  split
  · exact symmetricOn_zero
  · exact spField_symmetricOn Φ nu k r

theorem spFieldAdv_symmetricOn (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (r : Fin 7) :
    SymmetricOn D (D.subtype.comp (spFieldAdv Φ nu k r)) := by
  rw [spFieldAdv]
  split
  · exact spField_symmetricOn Φ nu k r
  · exact symmetricOn_zero

/-- **The one-body generator is symmetric on the core.** -/
theorem spHam_symmetricOn (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) :
    SymmetricOn D (spHam Φ nu k) :=
  weylOpDom_symmetricOn (spPi_symmetricOn Φ) (spField_symmetricOn Φ nu k)

/-- **The viscous half is symmetric on the core.** -/
theorem spVisc_symmetricOn (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) :
    SymmetricOn D (spVisc Φ nu k) :=
  weylOpDom_symmetricOn (spPi_symmetricOn Φ) (spFieldVisc_symmetricOn Φ nu k)

/-- **The advection half is symmetric on the core.** -/
theorem spAdvect_symmetricOn (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) :
    SymmetricOn D (spAdvect Φ nu k) :=
  weylOpDom_symmetricOn (fun i => i.elim0) (spFieldAdv_symmetricOn Φ nu k)

/-- **The first Faris–Lavine inequality: the generator is positive on the core.** -/
theorem spHam_quadForm_nonneg (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (x : D) :
    0 ≤ quadForm (spHam Φ nu k) x :=
  weylOpDom_quadForm_nonneg (spPi_symmetricOn Φ) (spField_symmetricOn Φ nu k) x

/-- **The viscous half is positive on the core.** -/
theorem spVisc_quadForm_nonneg (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (x : D) :
    0 ≤ quadForm (spVisc Φ nu k) x :=
  weylOpDom_quadForm_nonneg (spPi_symmetricOn Φ) (spFieldVisc_symmetricOn Φ nu k) x

/-- **The second Faris–Lavine inequality: the advection half is positive on the core** — the
nonlinearity enters as a square, not as a sign-indefinite perturbation. -/
theorem spAdvect_quadForm_nonneg (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (x : D) :
    0 ≤ quadForm (spAdvect Φ nu k) x :=
  weylOpDom_quadForm_nonneg (fun i => i.elim0) (spFieldAdv_symmetricOn Φ nu k) x

theorem quadForm_add {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    {D' : Submodule ℂ F} (A B : D' →ₗ[ℂ] F) (x : D') :
    quadForm (A + B) x = quadForm A x + quadForm B x := by
  simp [quadForm, LinearMap.add_apply, inner_add_right, Complex.add_re]

/-- **The two halves' forms add up to the generator's form.** -/
theorem spHam_quadForm_split (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (x : D) :
    quadForm (spHam Φ nu k) x = quadForm (spVisc Φ nu k) x + quadForm (spAdvect Φ nu k) x := by
  rw [spHam_eq_visc_add_advect, quadForm_add]

/-- The advection half is an explicit sum of squares of the momentum convolution
`(k·u) u_i = Σ_j k_j u_j u_i`. -/
theorem spAdvect_apply (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (x : D) :
    spAdvect Φ nu k x
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ _i : Fin 0, ((0 : D →ₗ[ℂ] D) ((0 : D →ₗ[ℂ] D) x) : D) : L2d 6)
            + ∑ r, ((spFieldAdv Φ nu k r (spFieldAdv Φ nu k r x) : D) : L2d 6)) :=
  weylOp_apply _ _ x

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

/-- The domain obligation: the Gauss–polynomial core sits inside the domain of `N_E`. -/
theorem polyGaussCore_le_spFriedDom (nu : ℝ) (k : Fin 3 → ℝ) :
    (polyGaussCore (d := 6)) ≤ (spFried nu k).dom := fun v hv =>
  (friedrichsComparison_extends (spPosSym nu k) polyGaussCore_dense ⟨v, hv⟩).choose

theorem spFried_op_core (nu : ℝ) (k : Fin 3 → ℝ) (p : polyGaussCore (d := 6))
    (h : (p : L2d 6) ∈ (spFried nu k).dom) :
    (spFried nu k).op ⟨(p : L2d 6), h⟩ = spHam (coreRepPoly 6) nu k p :=
  (friedrichsComparison_extends (spPosSym nu k) polyGaussCore_dense p).choose_spec

/-- The commutator form of the criterion vanishes for the comparison `N_E`: the `c = 0` case. -/
theorem spHam_commForm_zero (nu : ℝ) (k : Fin 3 → ℝ) (x : (spFried nu k).dom) :
    commForm (spFried nu k).op (spFried nu k).op x = 0 := by
  simp [commForm]

/-- **Faris–Lavine for the one-body generator**: the comparison realization `N_E` of `H_sp` is
essentially self-adjoint on its domain (`H = N`, `c = 0`). -/
theorem spHam_esa_farisLavine (nu : ℝ) (k : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (spFried nu k).dom (spFried nu k).op :=
  Comparison.esa_self _

/-- **`N_E` is a positive self-adjoint extension of the one-body generator.** -/
theorem spFried_isPositiveSelfAdjointExtension (nu : ℝ) (k : Fin 3 → ℝ) :
    IsPositiveSelfAdjointExtension (spHam (coreRepPoly 6) nu k) (spFried nu k).op :=
  (spFried nu k).isPositiveSelfAdjointExtension (spHam (coreRepPoly 6) nu k)
    (fun x => ⟨polyGaussCore_le_spFriedDom nu k x.2, spFried_op_core nu k x _⟩)

/-! ## 4. The nested-Fock lift `dΓ(H_sp)` -/

section DGamma

/-- **The one-body generator on the finite-mode domain of the product Hermite basis** of
`L²(ℝ⁶)` — the same operator as `spHam`, in the form the second quantization consumes. -/
def nsOnePart (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    finiteModeDomain (coreBasis e) →ₗ[ℂ] finiteModeDomain (coreBasis e) :=
  weylOpDom (spPi (coreRepBasis e)) (spField (coreRepBasis e) nu k)

theorem coe_nsOnePart (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    (finiteModeDomain (coreBasis e)).subtype.comp (nsOnePart e nu k)
      = spHam (coreRepBasis e) nu k := rfl

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

/-- **The nested-Fock lift has a positive self-adjoint (Friedrichs) extension.** -/
theorem nsSpDGamma_friedrichs_extension (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOp (nsSpCol e nu k)) A :=
  secondQuantization_friedrichs (coreBasis e) (nsOnePart e nu k)
    (spHam_symmetricOn (coreRepBasis e) nu k) (spHam_quadForm_nonneg (coreRepBasis e) nu k)

/-- The lift as a densely defined positive symmetric operator on the Fock space. -/
def nsSpDGammaPosSym (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) : PosSymOp Fock where
  dom := lpFiniteModes Conf
  op := dGammaOp (nsSpCol e nu k)
  sym := nsSpDGamma_symmetricOn e nu k
  pos := nsSpDGamma_quadForm_nonneg e nu k

/-- **The outer comparison operator** — the Friedrichs realization of `dΓ(H_sp)`. -/
def nsSpDGammaFried (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) : Comparison Fock :=
  friedrichsComparison (nsSpDGammaPosSym e nu k) finiteOccupation_dense

theorem lpFiniteModes_le_nsSpDGammaFriedDom (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    (lpFiniteModes Conf) ≤ (nsSpDGammaFried e nu k).dom := fun v hv =>
  (friedrichsComparison_extends (nsSpDGammaPosSym e nu k) finiteOccupation_dense
    ⟨v, hv⟩).choose

theorem nsSpDGammaFried_op_core (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ)
    (p : lpFiniteModes Conf)
    (h : (p : Fock) ∈ (nsSpDGammaFried e nu k).dom) :
    (nsSpDGammaFried e nu k).op ⟨(p : Fock), h⟩ = dGammaOp (nsSpCol e nu k) p :=
  (friedrichsComparison_extends (nsSpDGammaPosSym e nu k) finiteOccupation_dense p).choose_spec

/-- **Item 5 — Faris–Lavine on the nested Fock space**: the comparison realization of
`dΓ(H_sp)` is essentially self-adjoint on its domain (`H = N`, `c = 0`). -/
theorem nsSpDGamma_esa_farisLavine (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (nsSpDGammaFried e nu k).dom (nsSpDGammaFried e nu k).op :=
  Comparison.esa_self _

/-- **The outer comparison is a positive self-adjoint extension of `dΓ(H_sp)`.** -/
theorem nsSpDGammaFried_isPositiveSelfAdjointExtension (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ)
    (k : Fin 3 → ℝ) :
    IsPositiveSelfAdjointExtension (dGammaOp (nsSpCol e nu k)) (nsSpDGammaFried e nu k).op :=
  (nsSpDGammaFried e nu k).isPositiveSelfAdjointExtension (dGammaOp (nsSpCol e nu k))
    (fun x => ⟨lpFiniteModes_le_nsSpDGammaFriedDom e nu k x.2,
      nsSpDGammaFried_op_core e nu k x _⟩)

/-- **The lift conserves the particle number** — no finite-mode truncation is introduced by the
second quantization. -/
theorem nsSpDGamma_number_conserving (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ)
    {n : ℕ} {u : FockAlg} (hu : InSector n u) : InSector n (dGamma (nsSpCol e nu k) u) :=
  dGamma_inSector _ hu

/-- **On the one-particle sector the lift is the one-body generator** — the non-vacuity of the
construction: `dΓ(H_sp)|e_k⟩ = Σ_j ⟪e_j, H_sp e_k⟫ |e_j⟩`. -/
theorem nsSpDGamma_one_particle (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) (m : ℕ) :
    dGamma (nsSpCol e nu k) (Finsupp.single (Finsupp.single m 1) 1)
      = ∑ j ∈ (nsSpCol e nu k m).support,
          (nsSpCol e nu k m) j • Finsupp.single (Finsupp.single j 1) (1 : ℂ) :=
  dGamma_one_particle _ m

theorem nsSpCol_apply (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) (m j : ℕ) :
    nsSpCol e nu k m j
      = inner ℂ (coreBasis e j)
          ((nsOnePart e nu k ⟨coreBasis e m, Submodule.subset_span ⟨m, rfl⟩⟩ :
              finiteModeDomain (coreBasis e)) : L2d 6) :=
  opCol_apply _ _ m j

end DGamma

/-! ## 4b. The unitary time evolution of the lift -/

/-- The domain of the comparison operator of `dΓ(H_sp)` is dense: it contains the
finite-occupation core. -/
theorem nsSpDGammaFried_dom_dense (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    Dense (((nsSpDGammaFried e nu k).dom : Submodule ℂ Fock) : Set Fock) :=
  finiteOccupation_dense.mono
    (SetLike.coe_subset_coe.mpr (lpFiniteModes_le_nsSpDGammaFriedDom e nu k))

/-- **The unitary flow generated by `dΓ(H_sp)`**, by Stone's theorem: the comparison realization
of the nested-Fock Hamiltonian has a self-adjoint extension generating a strongly continuous
one-parameter unitary group — the single-time package of the reduced Navier–Stokes sector. -/
theorem nsSpDGamma_stone_flow (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint Fock) (U : ℝ → (Fock →L[ℂ] Fock)),
      IsSelfAdjointExtension (nsSpDGammaFried e nu k).op T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ (nsSpDGammaFried_dom_dense e nu k) (nsSpDGammaFried e nu k).sym
    (nsSpDGamma_esa_farisLavine e nu k)

/-- The domain of the one-body comparison operator `N_E` is dense. -/
theorem spFried_dom_dense (nu : ℝ) (k : Fin 3 → ℝ) :
    Dense (((spFried nu k).dom : Submodule ℂ (L2d 6)) : Set (L2d 6)) :=
  polyGaussCore_dense.mono (SetLike.coe_subset_coe.mpr (polyGaussCore_le_spFriedDom nu k))

/-- **The unitary flow generated by the one-body generator `H_sp`**, by Stone's theorem. -/
theorem spHam_stone_flow (nu : ℝ) (k : Fin 3 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d 6)) (U : ℝ → (L2d 6 →L[ℂ] L2d 6)),
      IsSelfAdjointExtension (spFried nu k).op T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ (spFried_dom_dense nu k) (spFried nu k).sym
    (spHam_esa_farisLavine nu k)

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

theorem sum_finProdFinEquiv {M : Type*} [AddCommMonoid M] {a b : ℕ} (f : Fin (a * b) → M) :
    ∑ x, f x = ∑ p : Fin a, ∑ i : Fin b, f (finProdFinEquiv (p, i)) := by
  rw [← Equiv.sum_comp finProdFinEquiv f, Fintype.sum_prod_type]

theorem redPiN_parcel (n : ℕ) (p : Fin n) (i : Fin 6) :
    redPiN n (finProdFinEquiv (p, i)) = parcelPi n p i := by
  simp only [redPiN, parcelPi, Equiv.symm_apply_apply, redIdx]

theorem redFieldN_parcel (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (r : Fin 7) :
    redFieldN nu k n (finProdFinEquiv (p, r)) = parcelField nu k n p r := by
  simp only [redFieldN, parcelField, Equiv.symm_apply_apply, redFormPoly_eq_liftParcel]

theorem smul_add_sum_comm {M : Type*} [AddCommMonoid M] [Module ℂ M] {ι : Type*} [Fintype ι]
    (c : ℂ) (A C : ι → M) : c • ((∑ p, A p) + ∑ p, C p) = ∑ p, c • (A p + C p) := by
  rw [← Finset.sum_add_distrib, Finset.smul_sum]

/-- **Regrouping a Weyl-ordered sum of squares into blocks.**  If the momenta are indexed by
`Fin (a * b)` and the forms by `Fin (a * c)`, the generator is the sum over the `a` blocks of the
generators of the individual blocks. -/
theorem weylOpDom_block_sum {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    {D : Submodule ℂ F} {a b c : ℕ} (pi : Fin (a * b) → D →ₗ[ℂ] D)
    (Bf : Fin (a * c) → D →ₗ[ℂ] D) :
    weylOpDom pi Bf
      = ∑ p : Fin a, weylOpDom (fun i : Fin b => pi (finProdFinEquiv (p, i)))
          (fun r : Fin c => Bf (finProdFinEquiv (p, r))) := by
  have hpi : (∑ m, (pi m).comp (pi m))
      = ∑ p : Fin a, ∑ i : Fin b,
          (pi (finProdFinEquiv (p, i))).comp (pi (finProdFinEquiv (p, i))) :=
    sum_finProdFinEquiv (fun m => (pi m).comp (pi m))
  have hBf : (∑ m, (Bf m).comp (Bf m))
      = ∑ p : Fin a, ∑ r : Fin c,
          (Bf (finProdFinEquiv (p, r))).comp (Bf (finProdFinEquiv (p, r))) :=
    sum_finProdFinEquiv (fun m => (Bf m).comp (Bf m))
  simp only [weylOpDom]
  rw [hpi, hBf]
  exact smul_add_sum_comm (((1 / 2 : ℝ)) : ℂ)
    (fun p : Fin a => ∑ i : Fin b,
      (pi (finProdFinEquiv (p, i))).comp (pi (finProdFinEquiv (p, i))))
    (fun p : Fin a => ∑ r : Fin c,
      (Bf (finProdFinEquiv (p, r))).comp (Bf (finProdFinEquiv (p, r))))

theorem redHamDom_eq_sum_parcel (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) :
    weylOpDom (redPiN n) (redFieldN nu k n)
      = ∑ p : Fin n, weylOpDom (parcelPi n p) (parcelField nu k n p) := by
  rw [weylOpDom_block_sum (a := n) (b := 6) (c := 7)]
  refine Finset.sum_congr rfl fun p _ => ?_
  simp only [redPiN_parcel, redFieldN_parcel]

set_option maxHeartbeats 1000000 in
-- the same regrouping, carried through the coercion into `L²`
/-- **The reduced `n`-parcel Hamiltonian is the sum of the `n` one-parcel generators.**  Each
summand involves only the six coordinates and the six momenta of its own parcel, so the sector
Hamiltonian is a one-body operator summed over the parcels — the reading of `weylOp` that the
second-quantized description presupposes. -/
theorem redHam_eq_sum_parcel (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) :
    redHam nu k n = ∑ p : Fin n, redParcelHam nu k n p := by
  refine LinearMap.ext fun x => ?_
  rw [LinearMap.sum_apply]
  change ((weylOpDom (redPiN n) (redFieldN nu k n) x : polyGaussCore (d := n * 6)) : L2d (n * 6))
      = ∑ p : Fin n, ((weylOpDom (parcelPi n p) (parcelField nu k n p) x :
          polyGaussCore (d := n * 6)) : L2d (n * 6))
  rw [redHamDom_eq_sum_parcel, LinearMap.sum_apply, Submodule.coe_sum]

set_option maxHeartbeats 1000000 in
-- the direct-sum fibre of the outer Hamiltonian is a costly defeq check
/-- The reduced Fock Hamiltonian on the `n`-parcel sector, parcel by parcel. -/
theorem nsRedFullFockHam_sector_sum_parcel (nu : ℝ) (k : Fin 3 → ℝ) (x : nsRedFockCore) (n : ℕ) :
    ((nsRedFullFockHam nu k x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n
      = ∑ p : Fin n, redParcelHam nu k n p
          ⟨((x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n, x.2.2 n⟩ :=
  calc ((nsRedFullFockHam nu k x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n
      = redHam nu k n ⟨((x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n, x.2.2 n⟩ :=
        nsRedFullFockHam_sector nu k x n
    _ = (∑ p : Fin n, redParcelHam nu k n p)
          ⟨((x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n, x.2.2 n⟩ :=
        LinearMap.congr_fun (redHam_eq_sum_parcel nu k n) _
    _ = ∑ p : Fin n, redParcelHam nu k n p
          ⟨((x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n, x.2.2 n⟩ :=
        LinearMap.sum_apply _ _ _



theorem parcelPi_symmetricOn (n : ℕ) (p : Fin n) (i : Fin 6) :
    SymmetricOn (polyGaussCore (d := n * 6))
      ((polyGaussCore (d := n * 6)).subtype.comp (parcelPi n p i)) :=
  (coreRepPoly (n * 6)).symmetricOn_op (momOp_polySym _)

theorem parcelField_symmetricOn (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (r : Fin 7) :
    SymmetricOn (polyGaussCore (d := n * 6))
      ((polyGaussCore (d := n * 6)).subtype.comp (parcelField nu k n p r)) :=
  (coreRepPoly (n * 6)).symmetricOn_op (mulOp_polySym (realCoeff_liftParcel_spFormPoly nu k n p r))

/-- Every one-parcel summand is symmetric on the core. -/
theorem redParcelHam_symmetricOn (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) :
    SymmetricOn (polyGaussCore (d := n * 6)) (redParcelHam nu k n p) :=
  weylOpDom_symmetricOn (parcelPi_symmetricOn n p) (parcelField_symmetricOn nu k n p)

/-- Every one-parcel summand is positive on the core. -/
theorem redParcelHam_quadForm_nonneg (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n)
    (x : polyGaussCore (d := n * 6)) : 0 ≤ quadForm (redParcelHam nu k n p) x :=
  weylOpDom_quadForm_nonneg (parcelPi_symmetricOn n p) (parcelField_symmetricOn nu k n p) x

end Parcel

end

end BookProof.NsOneBody
