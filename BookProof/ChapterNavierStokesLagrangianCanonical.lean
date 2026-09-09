import Mathlib
import BookProof.ChapterNavierStokesCanonicalVector
import BookProof.ChapterNavierStokesLagrangianKatoRellich
import BookProof.ChapterStoneBridge

/-!
# The canonical (ladder) realization of the Lagrangian Navier–Stokes Hamiltonian

The Eulerian strand of the Navier–Stokes thread has a canonical/ladder reading of
its full quadratic symbol (`BookProof.ChapterNavierStokesCanonicalVector`) and a
Hermite realization of the fiber generator
(`BookProof.ChapterNavierStokesHermiteCanonical`).  The Lagrangian (parcel)
strand had essential self-adjointness (`ChapterNavierStokesLagrangianKatoRellich`),
the Hashimoto/SIRK selection, the Fock-of-Fock lifting and the Stone flow, but its
positive second-order part

`T = ½ ∑ᵢ Pᵢ² + ν ∑ᵢ Qᵢ²`

was realized concretely only on the abstract *diagonal* instance `diagKR` of
`ℓ²(ℕ)`, where `Pᵢ` and `Qᵢ` commute.  This module removes that asymmetry: it
realizes the parcel momenta `Pᵢ` and the viscous gradients `Qᵢ` as the genuinely
**non-commuting** canonical pairs of a Hermite basis of the trajectory space
`ℓ²(Fin 3 → ℕ)`, and proves the second-order part is essentially self-adjoint
there.

## The construction

For a viscosity `ν > 0` put `ω = √(2ν)` and, out of the Hermite ladder operators
`a_i`, `a_i†` of `BookProof.NavierStokesFlow.CanonicalVector`,

`Qᵢ = ω^{-1/2} · (a_i + a_i†)/√2`,   `Pᵢ = ω^{1/2} · i(a_i† − a_i)/√2`.

These are the position and momentum of the oscillator of frequency `ω`; the
canonical commutation relations survive the rescaling (`comm_lagP_lagQ`,
`comm_lagP_lagQ_of_ne`), so `Pᵢ` and `Qᵢ` genuinely fail to commute — the point
on which the diagonal instance `diagKR` was silent.

The identity that makes the module work is

`½ Pᵢ² + ν Qᵢ² = (ω/2)(πᵢ² + uᵢ²) = ω (a_i† a_i + ½)`,

which is exactly the choice `ω = √(2ν)` (`lagT_eq_number`).  Summed over the
three parcel directions the Lagrangian second-order part is therefore the
number operator of the trajectory-space Hermite basis, `T = ω(N + 3/2)`, whose
eigenvectors are the Hermite states `e_β` (`lagT_coreState`) — a total family,
so `T` is essentially self-adjoint on the Hermite core (`lagT_esa`), unbounded
(`lagT_not_bounded`).

## What is proved

* `lagQ`, `lagP` — the canonical pairs of the trajectory space, with
  `comm_lagP_lagQ` (`[Pᵢ, Qᵢ] = −i`), `comm_lagP_lagQ_of_ne` and the symmetry
  statements `lagQ_isSymmetricDom`, `lagP_isSymmetricDom` (from the adjoint
  relation `inner_ann_cre` between the ladder operators);
* `lagT_eq_number` — `½ ∑Pᵢ² + ν ∑Qᵢ² = ω (N + 3/2)`, `N = ∑ a_i† a_i`;
* `lagT_coreState`, `lagT_esa`, `lagT_not_bounded` — the Hermite states
  diagonalize it, it is essentially self-adjoint on the Hermite core and it is
  unbounded;
* `lagCanData` — the resulting `LagrangianFullData` on `ℓ²(Fin 3 → ℕ)`: the
  canonical/ladder realization of the transformed Navier–Stokes Hamiltonian,
  with the physical drift `Dᵢ = Pᵢ` and an arbitrary external force;
* `lagCan_secondOrder_eq`, `lagCan_esa` — its second-order part is the operator
  above and the **full** transformed Hamiltonian is essentially self-adjoint on
  the Hermite core, by the Kato–Rellich relative bound of
  `ChapterNavierStokesLagrangianKatoRellich`;
* `lagCan_stone_flow` — hence the canonical Lagrangian Hamiltonian generates a
  complete unitary flow (Stone), bringing the Lagrangian strand to the same
  realization level as the Eulerian one.

## Honest boundary

Unchanged (Contention D5): nothing here claims global regularity of the
*classical* Navier–Stokes PDE.  The trajectory space is the Hermite
(occupation-number) realization `ℓ²(Fin 3 → ℕ)` of the parcel coordinates, in
which `Qᵢ` is the coordinate and `Pᵢ = −i∂/∂Xᵢ` the momentum, exactly as on the
Eulerian side.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace LagrangianCanonical

open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

/-! ## The adjoint relation between the ladder operators -/

theorem raise_injective (i : Fin 3) : Function.Injective (raise i) := by
  intro β γ h
  have := congrArg (lower i) h
  simpa using this

/-- Off the range of `raise i` — i.e. at the multi-indices with `β i = 0` — the
creation amplitude vanishes. -/
theorem cFun_vanishes_off_range (i : Fin 3) (X : Vel → ℂ) {β : Vel}
    (h : β ∉ Set.range (raise i)) (Y : Vel → ℂ) :
    (Real.sqrt (β i) : ℂ) * X (lower i β) * Y β = 0 := by
  have hzero : β i = 0 := by
    by_contra hne
    exact h ⟨lower i β, raise_lower i (Nat.one_le_iff_ne_zero.mpr hne)⟩
  simp [hzero]

/-- **The ladder operators are mutually adjoint** on the finite-mode core:
`⟪x, a_i y⟫ = ⟪a_i† x, y⟫`. -/
theorem inner_ann_cre (i : Fin 3) (x y : lpFiniteModes Vel) :
    (inner ℂ ((x : L2I Vel)) ((ann i y : lpFiniteModes Vel) : L2I Vel) : ℂ)
      = inner ℂ ((cre i x : lpFiniteModes Vel) : L2I Vel) ((y : L2I Vel)) := by
  classical
  have hL := lp.hasSum_inner (𝕜 := ℂ) ((x : L2I Vel)) ((ann i y : lpFiniteModes Vel) : L2I Vel)
  have hR := lp.hasSum_inner (𝕜 := ℂ) ((cre i x : lpFiniteModes Vel) : L2I Vel) ((y : L2I Vel))
  have hLfun : (fun β => (inner ℂ (((x : L2I Vel) : Vel → ℂ) β)
        ((((ann i y : lpFiniteModes Vel) : L2I Vel) : Vel → ℂ) β) : ℂ))
      = fun β => (Real.sqrt ((β i : ℝ) + 1) : ℂ)
          * (starRingEnd ℂ) (((x : L2I Vel) : Vel → ℂ) β)
          * ((y : L2I Vel) : Vel → ℂ) (raise i β) := by
    funext β
    have hcoe : ((((ann i y : lpFiniteModes Vel) : L2I Vel) : Vel → ℂ) β)
        = (Real.sqrt ((β i : ℝ) + 1) : ℂ) * ((y : L2I Vel) : Vel → ℂ) (raise i β) := rfl
    simp only [RCLike.inner_apply, hcoe]
    ring
  have hRfun : (fun β => (inner ℂ ((((cre i x : lpFiniteModes Vel) : L2I Vel) : Vel → ℂ) β)
        (((y : L2I Vel) : Vel → ℂ) β) : ℂ))
      = fun β => (Real.sqrt (β i : ℝ) : ℂ)
          * (starRingEnd ℂ) (((x : L2I Vel) : Vel → ℂ) (lower i β))
          * ((y : L2I Vel) : Vel → ℂ) β := by
    funext β
    have hcoe : (((cre i x : lpFiniteModes Vel) : L2I Vel) : Vel → ℂ) β
        = (Real.sqrt (β i : ℝ) : ℂ) * ((x : L2I Vel) : Vel → ℂ) (lower i β) := rfl
    simp only [RCLike.inner_apply, hcoe, map_mul, Complex.conj_ofReal]
    ring
  rw [hLfun] at hL
  rw [hRfun] at hR
  -- the two summand families agree after the reindexing `β ↦ raise i β`
  set g : Vel → ℂ := fun β => (Real.sqrt (β i : ℝ) : ℂ)
      * (starRingEnd ℂ) (((x : L2I Vel) : Vel → ℂ) (lower i β))
      * ((y : L2I Vel) : Vel → ℂ) β with hg
  have hsupp : Function.support g ⊆ Set.range (raise i) := by
    intro β hβ
    by_contra hnot
    exact hβ (cFun_vanishes_off_range i
      (fun γ => (starRingEnd ℂ) (((x : L2I Vel) : Vel → ℂ) γ)) hnot _)
  have hcomp : (fun γ => g (raise i γ))
      = fun β => (Real.sqrt ((β i : ℝ) + 1) : ℂ)
          * (starRingEnd ℂ) (((x : L2I Vel) : Vel → ℂ) β)
          * ((y : L2I Vel) : Vel → ℂ) (raise i β) := by
    funext γ
    simp only [hg, raise_self, lower_raise]
    push_cast
    ring
  have hkey : ∑' γ, g (raise i γ) = ∑' β, g β :=
    (raise_injective i).tsum_eq hsupp
  rw [hcomp] at hkey
  rw [← hL.tsum_eq, ← hR.tsum_eq]
  exact hkey

/-- The mirror form: `⟪x, a_i† y⟫ = ⟪a_i x, y⟫`. -/
theorem inner_cre_ann (i : Fin 3) (x y : lpFiniteModes Vel) :
    (inner ℂ ((x : L2I Vel)) ((cre i y : lpFiniteModes Vel) : L2I Vel) : ℂ)
      = inner ℂ ((ann i x : lpFiniteModes Vel) : L2I Vel) ((y : L2I Vel)) := by
  have h := inner_ann_cre i y x
  have h1 := congrArg (starRingEnd ℂ) h
  rw [inner_conj_symm, inner_conj_symm] at h1
  exact h1.symm

/-- The fiber coordinate is symmetric. -/
theorem pos_isSymmetricDom (i : Fin 3) : IsSymmetricDom (pos i) := by
  intro x y
  simp only [pos, LinearMap.smul_apply, LinearMap.add_apply, Submodule.coe_smul,
    Submodule.coe_add, inner_smul_left, inner_smul_right, inner_add_left, inner_add_right,
    Complex.conj_ofReal]
  rw [inner_cre_ann i x y, inner_ann_cre i x y]
  ring

/-- The momentum is symmetric. -/
theorem mom_isSymmetricDom (i : Fin 3) : IsSymmetricDom (mom i) := by
  intro x y
  simp only [mom, LinearMap.smul_apply, LinearMap.sub_apply, Submodule.coe_smul,
    Submodule.coe_sub, inner_smul_left, inner_smul_right, inner_sub_left, inner_sub_right,
    map_mul, Complex.conj_ofReal, Complex.conj_I]
  rw [inner_cre_ann i x y, inner_ann_cre i x y]
  ring

/-! ## The number operator of the Hermite basis -/

/-- The **number operator** of the mode `i`: `N_i = a_i† a_i`. -/
noncomputable def numOp (i : Fin 3) : lpFiniteModes Vel →ₗ[ℂ] lpFiniteModes Vel :=
  (cre i).comp (ann i)

@[simp] theorem crd_numOp (i : Fin 3) (x : lpFiniteModes Vel) :
    crd (numOp i x) = fun β => ((β i : ℝ) : ℂ) * crd x β := by
  simp only [numOp, LinearMap.comp_apply, crd_cre, crd_ann]
  exact cFun_aFun_self i (crd x)

theorem ann_comp_cre_eq (i : Fin 3) :
    (ann i).comp (cre i) = (cre i).comp (ann i) + LinearMap.id :=
  (sub_eq_iff_eq_add.mp (comm_ann_cre i)).trans (add_comm _ _)

/-- **The oscillator identity**: `u_i² + π_i² = 2 N_i + 1`. -/
theorem posSq_add_momSq (i : Fin 3) :
    (pos i).comp (pos i) + (mom i).comp (mom i)
      = (2 : ℂ) • numOp i + LinearMap.id := by
  have hhalf : ((1 / Real.sqrt 2 : ℝ) : ℂ) * ((1 / Real.sqrt 2 : ℝ) : ℂ) = (1 / 2 : ℂ) := by
    rw [inv_sqrt_two_sq]; norm_num
  have h1 : (pos i).comp (pos i)
      = (1 / 2 : ℂ) • ((cre i + ann i).comp (cre i + ann i)) := by
    simp only [pos, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul, hhalf]
  have h2 : (mom i).comp (mom i)
      = (-(1 / 2 : ℂ)) • ((cre i - ann i).comp (cre i - ann i)) := by
    simp only [mom, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
    congr 1
    have : Complex.I * ((1 / Real.sqrt 2 : ℝ) : ℂ) * (Complex.I * ((1 / Real.sqrt 2 : ℝ) : ℂ))
        = (Complex.I * Complex.I)
          * (((1 / Real.sqrt 2 : ℝ) : ℂ) * ((1 / Real.sqrt 2 : ℝ) : ℂ)) := by ring
    rw [this, hhalf, Complex.I_mul_I]
    ring
  have hPM : (cre i + ann i).comp (cre i + ann i) - (cre i - ann i).comp (cre i - ann i)
      = (2 : ℂ) • ((cre i).comp (ann i)) + (2 : ℂ) • ((ann i).comp (cre i)) := by
    simp only [LinearMap.comp_add, LinearMap.add_comp, LinearMap.comp_sub, LinearMap.sub_comp]
    module
  have hsplit : (pos i).comp (pos i) + (mom i).comp (mom i)
      = (1 / 2 : ℂ) • ((cre i + ann i).comp (cre i + ann i)
          - (cre i - ann i).comp (cre i - ann i)) := by
    rw [h1, h2]; module
  rw [hsplit, hPM, ann_comp_cre_eq i]
  simp only [numOp]
  module

/-! ## The canonical pairs of the trajectory space -/

variable (nu : ℝ)

/-- The oscillator frequency selected by the viscosity, `ω = √(2ν)`. -/
noncomputable def omega (nu : ℝ) : ℝ := Real.sqrt (2 * nu)

theorem omega_pos (hnu : 0 < nu) : 0 < omega nu := Real.sqrt_pos.mpr (by linarith)

theorem omega_sq (hnu : 0 ≤ nu) : omega nu * omega nu = 2 * nu :=
  Real.mul_self_sqrt (by linarith)

/-- **The viscous gradient** `Qᵢ = ω^{-1/2} uᵢ` — the parcel coordinate in the
oscillator normalization selected by the viscosity. -/
noncomputable def lagQ (nu : ℝ) (i : Fin 3) : lpFiniteModes Vel →ₗ[ℂ] lpFiniteModes Vel :=
  (((Real.sqrt (omega nu))⁻¹ : ℝ) : ℂ) • pos i

/-- **The parcel momentum** `Pᵢ = ω^{1/2} πᵢ`, `πᵢ = -i∂/∂Xᵢ`. -/
noncomputable def lagP (nu : ℝ) (i : Fin 3) : lpFiniteModes Vel →ₗ[ℂ] lpFiniteModes Vel :=
  ((Real.sqrt (omega nu) : ℝ) : ℂ) • mom i

theorem lagQ_isSymmetricDom (i : Fin 3) : IsSymmetricDom (lagQ nu i) :=
  IsSymmetricDom.real_smul (pos_isSymmetricDom i) _

theorem lagP_isSymmetricDom (i : Fin 3) : IsSymmetricDom (lagP nu i) :=
  IsSymmetricDom.real_smul (mom_isSymmetricDom i) _

/-- **The canonical commutation relation survives the rescaling**:
`[Pᵢ, Qᵢ] = −i`. -/
theorem comm_lagP_lagQ (hnu : 0 < nu) (i : Fin 3) :
    (lagP nu i).comp (lagQ nu i) - (lagQ nu i).comp (lagP nu i)
      = (-Complex.I) • LinearMap.id := by
  have hpos : 0 < Real.sqrt (omega nu) := Real.sqrt_pos.mpr (omega_pos nu hnu)
  have hscal : ((Real.sqrt (omega nu) : ℝ) : ℂ) * (((Real.sqrt (omega nu))⁻¹ : ℝ) : ℂ) = 1 := by
    rw [← Complex.ofReal_mul, mul_inv_cancel₀ (ne_of_gt hpos), Complex.ofReal_one]
  have hL : (lagP nu i).comp (lagQ nu i) - (lagQ nu i).comp (lagP nu i)
      = (((Real.sqrt (omega nu) : ℝ) : ℂ) * (((Real.sqrt (omega nu))⁻¹ : ℝ) : ℂ)) •
        ((mom i).comp (pos i) - (pos i).comp (mom i)) := by
    simp only [lagP, lagQ, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
    rw [mul_comm ((((Real.sqrt (omega nu))⁻¹ : ℝ)) : ℂ) (((Real.sqrt (omega nu) : ℝ)) : ℂ)]
    module
  rw [hL, comm_mom_pos i, hscal, one_smul]

/-- `[Pᵢ, Q_k] = 0` for distinct parcel directions. -/
theorem comm_lagP_lagQ_of_ne {i k : Fin 3} (h : i ≠ k) :
    (lagP nu i).comp (lagQ nu k) = (lagQ nu k).comp (lagP nu i) := by
  simp only [lagP, lagQ, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul,
    comm_mom_pos_of_ne h]
  rw [mul_comm]

/-! ## The second-order part is the number operator -/

/-- **The mode-wise identity** `½Pᵢ² + νQᵢ² = ω(Nᵢ + ½)`, the choice `ω = √(2ν)`. -/
theorem half_lagPSq_add_nu_lagQSq (hnu : 0 < nu) (i : Fin 3) :
    (1 / 2 : ℂ) • (lagP nu i).comp (lagP nu i)
        + ((nu : ℝ) : ℂ) • (lagQ nu i).comp (lagQ nu i)
      = ((omega nu : ℝ) : ℂ) • numOp i + ((omega nu / 2 : ℝ) : ℂ) • LinearMap.id := by
  have hw : 0 < omega nu := omega_pos nu hnu
  have hsq : Real.sqrt (omega nu) * Real.sqrt (omega nu) = omega nu :=
    Real.mul_self_sqrt (le_of_lt hw)
  have hspos : 0 < Real.sqrt (omega nu) := Real.sqrt_pos.mpr hw
  have hP : (lagP nu i).comp (lagP nu i) = ((omega nu : ℝ) : ℂ) • (mom i).comp (mom i) := by
    simp only [lagP, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul, ← Complex.ofReal_mul,
      hsq]
  have hQ : (lagQ nu i).comp (lagQ nu i)
      = (((omega nu)⁻¹ : ℝ) : ℂ) • (pos i).comp (pos i) := by
    have hinv : (Real.sqrt (omega nu))⁻¹ * (Real.sqrt (omega nu))⁻¹ = (omega nu)⁻¹ := by
      rw [← mul_inv, hsq]
    simp only [lagQ, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul, ← Complex.ofReal_mul,
      hinv]
  have hnuw : nu * (omega nu)⁻¹ = omega nu / 2 := by
    have h2 : omega nu * omega nu = 2 * nu := omega_sq nu (le_of_lt hnu)
    field_simp
    linarith [h2]
  have hcombine : (1 / 2 : ℂ) • (((omega nu : ℝ) : ℂ) • (mom i).comp (mom i))
        + ((nu : ℝ) : ℂ) • ((((omega nu)⁻¹ : ℝ) : ℂ) • (pos i).comp (pos i))
      = ((omega nu / 2 : ℝ) : ℂ) • ((pos i).comp (pos i) + (mom i).comp (mom i)) := by
    have hs : ((nu : ℝ) : ℂ) * (((omega nu)⁻¹ : ℝ) : ℂ) = ((omega nu / 2 : ℝ) : ℂ) := by
      rw [← Complex.ofReal_mul, hnuw]
    have hs2 : (1 / 2 : ℂ) * ((omega nu : ℝ) : ℂ) = ((omega nu / 2 : ℝ) : ℂ) := by
      push_cast
      ring
    simp only [smul_smul, hs, hs2]
    module
  rw [hP, hQ, hcombine, posSq_add_momSq i]
  have hs3 : ((omega nu / 2 : ℝ) : ℂ) * (2 : ℂ) = ((omega nu : ℝ) : ℂ) := by
    push_cast
    ring
  simp only [smul_add, smul_smul, hs3]

/-! ## The canonical Lagrangian data, and its essential self-adjointness -/

/-- **The Lagrangian (parcel) Navier–Stokes data in the canonical realization**:
the trajectory space is the Hermite space `ℓ²(Fin 3 → ℕ)` of the three parcel
coordinates, the parcel momenta and viscous gradients are the canonical pairs
`Pᵢ`, `Qᵢ` above (so they do **not** commute), the drift is the physical
`Dᵢ = Pᵢ` and there is no constraint term. -/
noncomputable def lagCanData (nu : ℝ) (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    LagrangianFullData (L2I Vel) where
  D := lpFiniteModes Vel
  P := lagP nu
  Q := lagQ nu
  drive := lagP nu
  force := f
  constraintOp := 0
  nu := nu
  dense := lpFiniteModes_dense
  P_symm := lagP_isSymmetricDom nu
  Q_symm := lagQ_isSymmetricDom nu
  drive_symm := lagP_isSymmetricDom nu
  constraint_symm := by intro x y; simp
  nu_nonneg := le_of_lt hnu

@[simp] theorem lagCanData_drive (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    (lagCanData nu hnu f).drive = (lagCanData nu hnu f).P := rfl

/-- The Lagrangian second-order part in its diagonal form: `ω(N + 3/2)`. -/
noncomputable def lagT (nu : ℝ) : lpFiniteModes Vel →ₗ[ℂ] lpFiniteModes Vel :=
  ((omega nu : ℝ) : ℂ) • (∑ i : Fin 3, numOp i)
    + ((3 * omega nu / 2 : ℝ) : ℂ) • LinearMap.id

/-- **The second-order part of the canonical Lagrangian Hamiltonian is the
number operator of the trajectory-space Hermite basis**: `T = ω(N + 3/2)` with
`N = ∑ᵢ a_i† a_i` and `ω = √(2ν)`. -/
theorem lagCan_secondOrder_eq (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    secondOrder (lagCanData nu hnu f) = lagT nu := by
  rw [lagT]
  have hmode := fun i => half_lagPSq_add_nu_lagQSq nu hnu i
  have hhalf : ((1 / 2 : ℝ) : ℂ) = (1 / 2 : ℂ) := by push_cast; ring
  simp only [secondOrder, LagrangianFullData.kinetic, LagrangianFullData.viscous, lagCanData,
    Finset.smul_sum, hhalf]
  rw [← Finset.sum_add_distrib]
  rw [Finset.sum_congr rfl fun i _ => hmode i]
  rw [Finset.sum_add_distrib, ← Finset.smul_sum]
  congr 1
  rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, ← Nat.cast_smul_eq_nsmul ℂ,
    smul_smul]
  congr 1
  push_cast
  ring

/-! ## Diagonalization by the Hermite states -/

theorem crd_coreState (β γ : Vel) : crd (coreState β) γ = if γ = β then 1 else 0 := by
  classical
  simp [crd, coreState, lp.single_apply, Pi.single_apply]

/-- The Hermite states are eigenvectors of the number operators. -/
theorem numOp_coreState (i : Fin 3) (β : Vel) :
    numOp i (coreState β) = ((β i : ℝ) : ℂ) • coreState β := by
  classical
  refine crd_injective ?_
  funext γ
  rw [crd_numOp, crd_smul]
  by_cases hγ : γ = β
  · subst hγ
    simp [crd_coreState]
  · simp [crd_coreState, hγ]

/-- The eigenvalue of the second-order part at the Hermite state `e_β`:
`ω(|β| + 3/2)`. -/
noncomputable def lagLam (nu : ℝ) (β : Vel) : ℝ :=
  omega nu * (∑ i : Fin 3, (β i : ℝ)) + 3 * omega nu / 2

/-- **The Hermite states diagonalize the Lagrangian second-order part.** -/
theorem lagT_coreState (β : Vel) :
    lagT nu (coreState β) = ((lagLam nu β : ℝ) : ℂ) • coreState β := by
  simp only [lagT, LinearMap.add_apply, LinearMap.smul_apply, LinearMap.sum_apply,
    LinearMap.id_apply, numOp_coreState, ← Finset.sum_smul, smul_smul, ← add_smul, lagLam]
  congr 1
  push_cast
  ring

/-- The Hermite states are total. -/
theorem coreState_total (w : L2I Vel)
    (hw : ∀ β : Vel, (inner ℂ ((coreState β : lpFiniteModes Vel) : L2I Vel) w : ℂ) = 0) :
    w = 0 := by
  ext β
  have h := hw β
  rw [show ((coreState β : lpFiniteModes Vel) : L2I Vel) = lp.single 2 β 1 from rfl,
    lp.inner_single_left] at h
  simpa using h

/-- **The Lagrangian second-order part is essentially self-adjoint on the
trajectory-space Hermite core** — the canonical-pair analogue of the diagonal
instance `diagKR`, with `Pᵢ` and `Qᵢ` genuinely non-commuting. -/
theorem lagT_hasZeroDeficiencyOn : HasZeroDeficiencyOn (lpFiniteModes Vel) (lagT nu) :=
  hasZeroDeficiencyOn_of_total_eigenvectors _ _ coreState (lagLam nu)
    (lagT_coreState nu) coreState_total

theorem lagCan_secondOrder_hasZeroDeficiencyOn (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    HasZeroDeficiencyOn (lagCanData nu hnu f).D (secondOrder (lagCanData nu hnu f)) := by
  rw [lagCan_secondOrder_eq nu hnu f]
  exact lagT_hasZeroDeficiencyOn nu

/-- **The full transformed (Lagrangian) Navier–Stokes Hamiltonian is essentially
self-adjoint on the trajectory-space Hermite core**, by the Kato–Rellich
relative bound: the drift `∑ fᵢ Pᵢ` is controlled by the positive second-order
part. -/
theorem lagCan_esa (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (lagCanData nu hnu f).D (lagrangianCore (lagCanData nu hnu f)) :=
  hFull_essentiallySelfAdjointOn_of_drive_eq_P (lagCanData nu hnu f) rfl le_rfl
    (fun v => by simp [lagCanData])
    ((essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn (lagCanData nu hnu f).D
      (secondOrder (lagCanData nu hnu f))).mpr (lagCan_secondOrder_hasZeroDeficiencyOn nu hnu f))

theorem lagCan_hFull_hasZeroDeficiencyOn (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    HasZeroDeficiencyOn (lagCanData nu hnu f).D (lagCanData nu hnu f).hFull :=
  hFull_hasZeroDeficiencyOn_of_drive_eq_P (lagCanData nu hnu f) rfl le_rfl
    (fun v => by simp [lagCanData]) (lagCan_secondOrder_hasZeroDeficiencyOn nu hnu f)

/-! ## Unboundedness, and the complete unitary flow -/

theorem norm_coreState (β : Vel) : ‖((coreState β : lpFiniteModes Vel) : L2I Vel)‖ = 1 := by
  have : ‖((coreState β : lpFiniteModes Vel) : L2I Vel)‖ = ‖(1 : ℂ)‖ :=
    lp.norm_single (by norm_num) β 1
  simpa using this

/-- **The canonical Lagrangian second-order part is unbounded**: its essential
self-adjointness is not a boundedness phenomenon. -/
theorem lagT_not_bounded (hnu : 0 < nu) :
    ¬ ∃ C : ℝ, ∀ v : lpFiniteModes Vel,
      ‖(lagT nu v : L2I Vel)‖ ≤ C * ‖(v : L2I Vel)‖ := by
  rintro ⟨C, hC⟩
  have hw : 0 < omega nu := omega_pos nu hnu
  set n : ℕ := ⌈|C| / (3 * omega nu)⌉₊ + 1 with hn
  have h3 : 0 < 3 * omega nu := by linarith
  have hn1 : |C| / (3 * omega nu) + 1 ≤ (n : ℝ) := by
    have := Nat.le_ceil (|C| / (3 * omega nu))
    rw [hn]
    push_cast
    linarith
  have hdiv : |C| / (3 * omega nu) * (3 * omega nu) = |C| := div_mul_cancel₀ _ (ne_of_gt h3)
  have hmul : (|C| / (3 * omega nu) + 1) * (3 * omega nu) ≤ (n : ℝ) * (3 * omega nu) :=
    mul_le_mul_of_nonneg_right hn1 (le_of_lt h3)
  have hbig : C < 3 * omega nu * (n : ℝ) := by
    have hCa : C ≤ |C| := le_abs_self C
    nlinarith [hmul, hdiv]
  have hb := hC (coreState (fun _ => n))
  rw [lagT_coreState nu, norm_coreState] at hb
  have hlam : lagLam nu (fun _ => n) = 3 * omega nu * (n : ℝ) + 3 * omega nu / 2 := by
    simp only [lagLam, Fin.sum_univ_three]
    ring
  rw [hlam] at hb
  simp only [Submodule.coe_smul, norm_smul, Complex.norm_real, Real.norm_eq_abs,
    norm_coreState, mul_one] at hb
  have hpos : 0 ≤ 3 * omega nu * (n : ℝ) + 3 * omega nu / 2 := by positivity
  rw [abs_of_nonneg hpos] at hb
  linarith

open BookProof.ChapterStoneResolvent BookProof.StoneBridge BookProof.EsaClosure in
/-- **The canonical Lagrangian Navier–Stokes Hamiltonian generates a complete
unitary flow.**  Essential self-adjointness on the trajectory-space Hermite core
selects the unique self-adjoint extension, and Stone's theorem turns it into the
global group `e^{-itT}` solving the Schrödinger equation on the domain. -/
theorem lagCan_stone_flow (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2I Vel)) (U : ℝ → (L2I Vel →L[ℂ] L2I Vel)),
      IsSelfAdjointExtension (lagrangianCore (lagCanData nu hnu f)) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa (lagrangianCore (lagCanData nu hnu f)) (lagCanData nu hnu f).dense
    (lagrangianCore_symmetricOn (lagCanData nu hnu f)) (lagCan_esa nu hnu f)

end LagrangianCanonical

end BookProof.NavierStokesFlow
