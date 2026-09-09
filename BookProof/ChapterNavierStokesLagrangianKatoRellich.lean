import Mathlib
import BookProof.ChapterKatoRellichRelative
import BookProof.ChapterNavierStokesLagrangianEsa
import BookProof.ChapterEsaClosure

/-!
# The Lagrangian route: Kato–Rellich control of the drift, and the Hashimoto
selection

This module closes the analytic step that the Lagrangian (parcel) route of the
Navier–Stokes thread was missing.  After the change of variables of
`BookProof.ChapterNavierStokesFlow` the Navier–Stokes Hamiltonian is

`ĥ_full = ½∑ᵢ Pᵢ² + ν ∑ᵢ Qᵢ² + ∑ᵢ fᵢ Dᵢ + C`,

a **positive** second-order part (advection plus viscosity — this is the whole
point of passing to the trajectory picture), a first-order drift, and a
zeroth-order constraint.  `BookProof.ChapterNavierStokesLagrangianEsa` builds
this operator without any truncation and proves it symmetric with positive
second-order part, but its essential self-adjointness was obtained there only
from *external* criteria (a complete flow, a bounded realization, or a total
family of common eigenvectors), and
`exists_lagrangianFullData_not_hasZeroDeficiencyOn` shows an unbounded drift can
destroy the property outright.

Here the drift is controlled by the positive second-order part itself, and
essential self-adjointness of the full operator follows from essential
self-adjointness of that second-order part alone.

## The mechanism

The positivity gain of the Lagrangian variables *is* the relative bound.  For
each `i`,

`‖Pᵢ v‖² = ⟪v, Pᵢ² v⟫ ≤ 2⟪v, (½∑ⱼPⱼ² + ν∑ⱼQⱼ²) v⟫ ≤ 2‖v‖ ‖T v‖`,

because every other term of `T = ½∑Pⱼ² + ν∑Qⱼ²` has a **nonnegative** quadratic
form.  With the elementary inequality `√(2AB) ≤ εB + A/(2ε)` this gives, for
every `ε > 0`,

`‖Pᵢ v‖ ≤ ε ‖T v‖ + (2ε)⁻¹ ‖v‖`  (`norm_P_le`),

i.e. any first-order term dominated by the parcel momenta is `T`-bounded **with
arbitrarily small relative bound** — the Kato–Rellich/Ikebe–Kato interpolation
of a first-order operator against a second-order one, in the exact form the
Lagrangian route asks for.  Adding a bounded constraint term and taking `ε`
small enough, the whole low-order part is `T`-bounded with relative bound `< 1`,
and `BookProof.KatoRellich.essentiallySelfAdjointOn_add_relBounded` applies.

## What is proved

* `secondOrder` / `lowOrder` and `hFull_eq_add` — the split of the transformed
  Hamiltonian into its positive second-order part and its low-order remainder;
* `norm_P_sq_le`, `norm_P_le`, `norm_sum_P_le` — the interpolation inequality:
  the parcel momenta are dominated by the positive second-order part with
  arbitrarily small relative bound;
* `lowOrder_relBound` — a drift dominated by the parcel momenta, together with a
  bounded constraint, is `T`-bounded with *any* prescribed relative bound
  `a > 0`;
* `hFull_essentiallySelfAdjointOn` and `hFull_hasZeroDeficiencyOn` — **the
  headline**: if the positive second-order part is essentially self-adjoint on
  the domain, so is the full transformed Navier–Stokes Hamiltonian.  The drift
  may be unbounded; no common eigenvectors, no flow, no boundedness is assumed;
* `drift_dominated_of_drive_eq_P` and
  `hFull_hasZeroDeficiencyOn_of_drive_eq_P` — the physical case in which the
  drift generators *are* the parcel momenta (`Dᵢ = Pᵢ`, the term `f·∇_X`), where
  the domination hypothesis is automatic;
* `hasZeroDeficiencyOn_of_lagrangian_katoRellich` — transported back through the
  unitary change of variables to the Eulerian operator;
* `lagrangianCore`, `lagrangian_selfAdjoint_extension`,
  `lagrangian_selfAdjoint_extension_unique`, `lagrangian_hashimoto_selects` and
  `lagrangian_shiftInvert_selects` — the Hashimoto/SIRK shift-invert selection
  theorem **on the Lagrangian side**, obtained from the Kato–Rellich essential
  self-adjointness rather than from the Eulerian chain: the shift-invert
  resolvents of the transformed generator exist, are bounded, satisfy the
  resolvent identity and the SIRK relation, have strongly convergent Galerkin
  truncations, and each of them determines the unique self-adjoint transformed
  generator;
* `diagKR`, `diagKR_hFull_essentiallySelfAdjointOn`, `diagKR_drift_not_bounded`
  and `diagKR_hashimoto_selects` — a genuinely infinite-dimensional, genuinely
  **unbounded** instance on `ℓ²(ℕ)` whose drift is not a bounded perturbation,
  so the bounded Kato–Rellich theorem does not apply to it and the relative one
  does;
* `jacobiLag_secondOrder_eq_zero` and
  `jacobiLag_drift_not_relativelyBounded` — the sharpness record of
  `ChapterNavierStokesLagrangianEsa` seen from here: in the counterexample the
  second-order part is `0`, so its drift is dominated by nothing, which is
  precisely the hypothesis of this module that fails.

## Honest boundary

Unchanged (Contention D5): nothing here claims global regularity of the
*classical* Navier–Stokes PDE.  Essential self-adjointness of the positive
second-order part `T` is a hypothesis of the abstract theorem — it is the
statement that the Lagrangian "Laplacian" `−½Δ_X − νΔ_{ξ,X}` is essentially
self-adjoint on the chosen core — and it is verified here only for the concrete
realization on `ℓ²(ℕ)`.  What the module supplies is the step the Lagrangian
route named as missing: the first-order drift is controlled by that second-order
part, so no separate hypothesis about the drift is needed.
-/

open Filter Topology

namespace BookProof.NavierStokesFlow

namespace LagrangianKatoRellich

open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

/-! ## The split into second-order and low-order parts -/

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)

/-- The **positive second-order part** `T = ½∑Pᵢ² + ν∑Qᵢ²` of the transformed
Hamiltonian: advection plus viscosity. -/
noncomputable def secondOrder : L.D →ₗ[ℂ] L.D := L.kinetic + L.viscous

/-- The low-order remainder `∑fᵢDᵢ + C`: the first-order drift plus the
zeroth-order volume-preservation constraint. -/
noncomputable def lowOrder : L.D →ₗ[ℂ] L.D := L.drift + L.constraintOp

/-- The transformed (Lagrangian) Navier–Stokes Hamiltonian, viewed as an
operator into the ambient space — the form the closure and shift-invert
machinery works with. -/
noncomputable def lagrangianCore : L.D →ₗ[ℂ] F := L.D.subtype.comp L.hFull

theorem hFull_eq_add : L.hFull = secondOrder L + lowOrder L := by
  simp only [LagrangianFullData.hFull, secondOrder, lowOrder]
  abel

theorem secondOrder_isSymmetricDom : IsSymmetricDom (secondOrder L) :=
  L.kinetic_isSymmetricDom.add L.viscous_isSymmetricDom

theorem lowOrder_isSymmetricDom : IsSymmetricDom (lowOrder L) :=
  L.drift_isSymmetricDom.add L.constraint_symm

theorem lagrangianCore_symmetricOn : SymmetricOn L.D (lagrangianCore L) :=
  fun x y => L.hFull_isSymmetricDom x y

/-- The quadratic form of the second-order part is the sum of the two positive
quadratic forms. -/
theorem secondOrder_inner (v : L.D) :
    (inner ℂ (v : F) (secondOrder L v : F) : ℂ).re
      = (inner ℂ (v : F) (L.kinetic v : F) : ℂ).re
        + (inner ℂ (v : F) (L.viscous v : F) : ℂ).re := by
  simp only [secondOrder, LinearMap.add_apply, Submodule.coe_add, inner_add_right,
    Complex.add_re]

/-! ### The interpolation inequality -/

/-- **The interpolation inequality, squared form.**  Each parcel momentum obeys
`‖Pᵢ v‖² ≤ 2‖v‖‖T v‖`: the square of the first-order operator is dominated by
the *quadratic form* of the positive second-order part, because every other
term of that form is nonnegative. -/
theorem norm_P_sq_le (v : L.D) (i : Fin 3) :
    ‖(L.P i v : F)‖ ^ 2 ≤ 2 * (‖(v : F)‖ * ‖(secondOrder L v : F)‖) := by
  have hk : (inner ℂ (v : F) (L.kinetic v : F) : ℂ).re
      = (1 / 2 : ℝ) * ∑ j : Fin 3, ‖(L.P j v : F)‖ ^ 2 := by
    rw [L.kinetic_inner v, Complex.ofReal_re]
  have hsingle : ‖(L.P i v : F)‖ ^ 2 ≤ ∑ j : Fin 3, ‖(L.P j v : F)‖ ^ 2 :=
    Finset.single_le_sum (f := fun j : Fin 3 => ‖(L.P j v : F)‖ ^ 2)
      (fun j _ => sq_nonneg _) (Finset.mem_univ i)
  have hv : 0 ≤ (inner ℂ (v : F) (L.viscous v : F) : ℂ).re := L.viscous_nonneg v
  have hform : (1 / 2 : ℝ) * ‖(L.P i v : F)‖ ^ 2
      ≤ (inner ℂ (v : F) (secondOrder L v : F) : ℂ).re := by
    rw [secondOrder_inner L v, hk]
    nlinarith
  have hcs : (inner ℂ (v : F) (secondOrder L v : F) : ℂ).re
      ≤ ‖(v : F)‖ * ‖(secondOrder L v : F)‖ := by
    calc (inner ℂ (v : F) (secondOrder L v : F) : ℂ).re
        ≤ ‖(inner ℂ (v : F) (secondOrder L v : F) : ℂ)‖ := Complex.re_le_norm _
      _ ≤ ‖(v : F)‖ * ‖(secondOrder L v : F)‖ := norm_inner_le_norm _ _
  linarith

/-- **The interpolation inequality.**  For every `ε > 0` the parcel momentum is
bounded by `ε` times the second-order part plus a multiple of the identity: the
first-order operators of the Lagrangian picture have *arbitrarily small*
relative bound with respect to the positive second-order part. -/
theorem norm_P_le (v : L.D) (i : Fin 3) {eps : ℝ} (heps : 0 < eps) :
    ‖(L.P i v : F)‖ ≤ eps * ‖(secondOrder L v : F)‖ + (1 / (2 * eps)) * ‖(v : F)‖ := by
  set A : ℝ := ‖(v : F)‖ with hA
  set B : ℝ := ‖(secondOrder L v : F)‖ with hB
  set x : ℝ := ‖(L.P i v : F)‖ with hx
  have hA0 : 0 ≤ A := norm_nonneg _
  have hB0 : 0 ≤ B := norm_nonneg _
  have hx0 : 0 ≤ x := norm_nonneg _
  have hsq : x ^ 2 ≤ 2 * (A * B) := norm_P_sq_le L v i
  have hR0 : 0 ≤ eps * B + (1 / (2 * eps)) * A := by positivity
  have hamgm : 2 * (A * B) ≤ (eps * B + (1 / (2 * eps)) * A) ^ 2 := by
    have h := sq_nonneg (eps * B - (1 / (2 * eps)) * A)
    have he : eps * (1 / (2 * eps)) = 1 / 2 := by field_simp
    nlinarith [h, he]
  nlinarith [hsq, hamgm, hR0, hx0]

/-- The interpolation inequality summed over the three components. -/
theorem norm_sum_P_le (v : L.D) {eps : ℝ} (heps : 0 < eps) :
    ∑ j : Fin 3, ‖(L.P j v : F)‖
      ≤ 3 * (eps * ‖(secondOrder L v : F)‖ + (1 / (2 * eps)) * ‖(v : F)‖) := by
  calc ∑ j : Fin 3, ‖(L.P j v : F)‖
      ≤ ∑ _j : Fin 3, (eps * ‖(secondOrder L v : F)‖ + (1 / (2 * eps)) * ‖(v : F)‖) :=
        Finset.sum_le_sum fun j _ => norm_P_le L v j heps
    _ = 3 * (eps * ‖(secondOrder L v : F)‖ + (1 / (2 * eps)) * ‖(v : F)‖) := by
        simp [Finset.sum_const]
        ring

/-! ### The relative bound for the low-order part -/

/-- **The low-order part is relatively bounded with any prescribed relative
bound.**  If the first-order drift is dominated by the parcel momenta and the
constraint term is bounded, then for every `a > 0` there is `b ≥ 0` with
`‖(∑fᵢDᵢ + C)v‖ ≤ a‖T v‖ + b‖v‖`. -/
theorem lowOrder_relBound {kap kap' cc : ℝ} (hkap : 0 ≤ kap) (hkap' : 0 ≤ kap') (hcc : 0 ≤ cc)
    (hdrift : ∀ v : L.D,
      ‖(L.drift v : F)‖ ≤ kap * (∑ j : Fin 3, ‖(L.P j v : F)‖) + kap' * ‖(v : F)‖)
    (hC : ∀ v : L.D, ‖(L.constraintOp v : F)‖ ≤ cc * ‖(v : F)‖) {a : ℝ} (ha : 0 < a) :
    ∃ b : ℝ, 0 ≤ b ∧ ∀ v : L.D,
      ‖(lowOrder L v : F)‖ ≤ a * ‖(secondOrder L v : F)‖ + b * ‖(v : F)‖ := by
  set K : ℝ := 3 * kap with hK
  have hK0 : 0 ≤ K := by positivity
  have hK1 : (0 : ℝ) < K + 1 := by linarith
  set eps : ℝ := a / (K + 1) with heps
  have heps0 : 0 < eps := div_pos ha hK1
  have hKeps : K * eps ≤ a := by
    rw [heps, mul_div_assoc', div_le_iff₀ hK1]
    nlinarith
  refine ⟨K * (1 / (2 * eps)) + kap' + cc, by positivity, fun v => ?_⟩
  have hA0 : 0 ≤ ‖(v : F)‖ := norm_nonneg _
  have hB0 : 0 ≤ ‖(secondOrder L v : F)‖ := norm_nonneg _
  have hsum : kap * (∑ j : Fin 3, ‖(L.P j v : F)‖)
      ≤ K * (eps * ‖(secondOrder L v : F)‖ + (1 / (2 * eps)) * ‖(v : F)‖) := by
    have := mul_le_mul_of_nonneg_left (norm_sum_P_le L v heps0) hkap
    rw [hK]
    nlinarith
  have hlow : (lowOrder L v : F) = (L.drift v : F) + (L.constraintOp v : F) := by
    simp [lowOrder]
  calc ‖(lowOrder L v : F)‖ ≤ ‖(L.drift v : F)‖ + ‖(L.constraintOp v : F)‖ := by
        rw [hlow]; exact norm_add_le _ _
    _ ≤ (kap * (∑ j : Fin 3, ‖(L.P j v : F)‖) + kap' * ‖(v : F)‖) + cc * ‖(v : F)‖ :=
        add_le_add (hdrift v) (hC v)
    _ ≤ K * (eps * ‖(secondOrder L v : F)‖ + (1 / (2 * eps)) * ‖(v : F)‖)
        + kap' * ‖(v : F)‖ + cc * ‖(v : F)‖ := by linarith
    _ ≤ a * ‖(secondOrder L v : F)‖
        + (K * (1 / (2 * eps)) + kap' + cc) * ‖(v : F)‖ := by nlinarith

/-! ### The Kato–Rellich theorem for the transformed Hamiltonian -/

/-- **The headline: Kato–Rellich for the transformed Navier–Stokes
Hamiltonian.**  If the *positive second-order part* `T = ½∑Pᵢ² + ν∑Qᵢ²` is
essentially self-adjoint on the domain, the first-order drift is dominated by
the parcel momenta and the constraint term is bounded, then the **full**
transformed Hamiltonian `ĥ_full = T + ∑fᵢDᵢ + C` is essentially self-adjoint on
the same domain.  The drift is allowed to be unbounded; only its domination by
`T` — a consequence of the positivity gained by the Lagrangian change of
variables — is used. -/
theorem hFull_essentiallySelfAdjointOn [CompleteSpace F] {kap kap' cc : ℝ}
    (hkap : 0 ≤ kap) (hkap' : 0 ≤ kap') (hcc : 0 ≤ cc)
    (hdrift : ∀ v : L.D,
      ‖(L.drift v : F)‖ ≤ kap * (∑ j : Fin 3, ‖(L.P j v : F)‖) + kap' * ‖(v : F)‖)
    (hC : ∀ v : L.D, ‖(L.constraintOp v : F)‖ ≤ cc * ‖(v : F)‖)
    (hT : EssentiallySelfAdjointOn L.D (L.D.subtype.comp (secondOrder L))) :
    EssentiallySelfAdjointOn L.D (lagrangianCore L) := by
  obtain ⟨b, hb0, hb⟩ := lowOrder_relBound L hkap hkap' hcc hdrift hC (a := 1 / 2) (by norm_num)
  have hsplit : lagrangianCore L
      = L.D.subtype.comp (secondOrder L) + L.D.subtype.comp (lowOrder L) := by
    rw [lagrangianCore, hFull_eq_add L]
    ext x
    simp
  rw [hsplit]
  refine essentiallySelfAdjointOn_add_relBounded _ _
    (fun x y => secondOrder_isSymmetricDom L x y) hT
    (fun x y => lowOrder_isSymmetricDom L x y) (a := 1 / 2) (b := b)
    (by norm_num) (by norm_num) hb0 ?_
  intro x
  simpa using hb x

/-- The same statement in the `HasZeroDeficiencyOn` form used throughout the
Navier–Stokes chapters. -/
theorem hFull_hasZeroDeficiencyOn [CompleteSpace F] {kap kap' cc : ℝ}
    (hkap : 0 ≤ kap) (hkap' : 0 ≤ kap') (hcc : 0 ≤ cc)
    (hdrift : ∀ v : L.D,
      ‖(L.drift v : F)‖ ≤ kap * (∑ j : Fin 3, ‖(L.P j v : F)‖) + kap' * ‖(v : F)‖)
    (hC : ∀ v : L.D, ‖(L.constraintOp v : F)‖ ≤ cc * ‖(v : F)‖)
    (hT : HasZeroDeficiencyOn L.D (secondOrder L)) :
    HasZeroDeficiencyOn L.D L.hFull :=
  (essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn L.D L.hFull).mp
    (hFull_essentiallySelfAdjointOn L hkap hkap' hcc hdrift hC
      ((essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn L.D (secondOrder L)).mpr hT))

/-! ### The physical case: the drift generators are the parcel momenta -/

/-- In the Lagrangian picture the first-order term is `f·∇_X`, i.e. the drift
generators *are* the parcel momenta.  Then the domination hypothesis holds
automatically, with `κ = ∑ᵢ|fᵢ|`. -/
theorem drift_dominated_of_drive_eq_P (hdrive : L.drive = L.P) (v : L.D) :
    ‖(L.drift v : F)‖
      ≤ (∑ i : Fin 3, |L.force i|) * (∑ j : Fin 3, ‖(L.P j v : F)‖) + 0 * ‖(v : F)‖ := by
  have hdriftsum : (L.drift v : F) = ∑ i : Fin 3, ((L.force i : ℝ) : ℂ) • (L.P i v : F) := by
    simp only [LagrangianFullData.drift, LinearMap.sum_apply, LinearMap.smul_apply,
      Submodule.coe_sum, Submodule.coe_smul, hdrive]
  have hterms : ‖(L.drift v : F)‖ ≤ ∑ i : Fin 3, |L.force i| * ‖(L.P i v : F)‖ := by
    rw [hdriftsum]
    refine le_trans (norm_sum_le _ _) (le_of_eq ?_)
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [norm_smul]
    simp
  have hle : ∀ i : Fin 3, |L.force i| * ‖(L.P i v : F)‖
      ≤ |L.force i| * (∑ j : Fin 3, ‖(L.P j v : F)‖) := by
    intro i
    refine mul_le_mul_of_nonneg_left ?_ (abs_nonneg _)
    exact Finset.single_le_sum (f := fun j : Fin 3 => ‖(L.P j v : F)‖)
      (fun j _ => norm_nonneg _) (Finset.mem_univ i)
  calc ‖(L.drift v : F)‖ ≤ ∑ i : Fin 3, |L.force i| * ‖(L.P i v : F)‖ := hterms
    _ ≤ ∑ i : Fin 3, |L.force i| * (∑ j : Fin 3, ‖(L.P j v : F)‖) :=
        Finset.sum_le_sum fun i _ => hle i
    _ = (∑ i : Fin 3, |L.force i|) * (∑ j : Fin 3, ‖(L.P j v : F)‖) := by
        rw [Finset.sum_mul]
    _ = (∑ i : Fin 3, |L.force i|) * (∑ j : Fin 3, ‖(L.P j v : F)‖) + 0 * ‖(v : F)‖ := by ring

/-- **Kato–Rellich in the physical Lagrangian case.**  With `Dᵢ = Pᵢ` and a
bounded constraint, essential self-adjointness of the positive second-order part
alone gives it for the full transformed Hamiltonian. -/
theorem hFull_essentiallySelfAdjointOn_of_drive_eq_P [CompleteSpace F] (hdrive : L.drive = L.P)
    {cc : ℝ} (hcc : 0 ≤ cc) (hC : ∀ v : L.D, ‖(L.constraintOp v : F)‖ ≤ cc * ‖(v : F)‖)
    (hT : EssentiallySelfAdjointOn L.D (L.D.subtype.comp (secondOrder L))) :
    EssentiallySelfAdjointOn L.D (lagrangianCore L) :=
  hFull_essentiallySelfAdjointOn L
    (Finset.sum_nonneg fun _ _ => abs_nonneg _) le_rfl hcc
    (drift_dominated_of_drive_eq_P L hdrive) hC hT

theorem hFull_hasZeroDeficiencyOn_of_drive_eq_P [CompleteSpace F] (hdrive : L.drive = L.P)
    {cc : ℝ} (hcc : 0 ≤ cc) (hC : ∀ v : L.D, ‖(L.constraintOp v : F)‖ ≤ cc * ‖(v : F)‖)
    (hT : HasZeroDeficiencyOn L.D (secondOrder L)) :
    HasZeroDeficiencyOn L.D L.hFull :=
  hFull_hasZeroDeficiencyOn L (Finset.sum_nonneg fun _ _ => abs_nonneg _) le_rfl hcc
    (drift_dominated_of_drive_eq_P L hdrive) hC hT

/-- **Back to the Eulerian operator.**  Combining the Kato–Rellich step with the
unitary change of variables: if the Eulerian Navier–Stokes Hamiltonian is
carried by a unitary `W` into the transformed Hamiltonian, and the transformed
*second-order* part is essentially self-adjoint, then the Eulerian operator is
essentially self-adjoint. -/
theorem hasZeroDeficiencyOn_of_lagrangian_katoRellich
    {G : Type*} [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]
    (d : FullEsa.NSFullData F) (L' : LagrangianFullData G) (W : F ≃ₗᵢ[ℂ] G)
    (hmap : ∀ x : d.D, W (x : F) ∈ L'.D) (hsurj : ∀ y : L'.D, ∃ x : d.D, W (x : F) = (y : G))
    (hint : ∀ x : d.D, (L'.hFull ⟨W (x : F), hmap x⟩ : G) = W ((d.hamiltonian x : F)))
    (hdrive : L'.drive = L'.P) {cc : ℝ} (hcc : 0 ≤ cc)
    (hC : ∀ v : L'.D, ‖(L'.constraintOp v : G)‖ ≤ cc * ‖(v : G)‖)
    (hT : HasZeroDeficiencyOn L'.D (secondOrder L')) :
    HasZeroDeficiencyOn d.D d.hamiltonian :=
  LagrangianEsa.NSFullData.hasZeroDeficiencyOn_of_lagrangian d L' W hmap hsurj hint
    (hFull_hasZeroDeficiencyOn_of_drive_eq_P L' hdrive hcc hC hT)

end Abstract

/-! ## The Hashimoto/SIRK selection on the Lagrangian side -/

section Selection

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (L : LagrangianFullData F)

/-- **The transformed Navier–Stokes generator is self-adjoint on the closure of
the Lagrangian core.** -/
theorem lagrangian_selfAdjoint_extension
    (hesa : EssentiallySelfAdjointOn L.D (lagrangianCore L)) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsSelfAdjointExtension (lagrangianCore L) A :=
  exists_isSelfAdjointExtension_of_esa (lagrangianCore L) L.dense
    (lagrangianCore_symmetricOn L) hesa

/-- **And it is the only one.** -/
theorem lagrangian_selfAdjoint_extension_unique
    (hesa : EssentiallySelfAdjointOn L.D (lagrangianCore L))
    {Dom₁ Dom₂ : Submodule ℂ F} {A₁ : Dom₁ →ₗ[ℂ] F} {A₂ : Dom₂ →ₗ[ℂ] F}
    (h₁ : IsSelfAdjointExtension (lagrangianCore L) A₁)
    (h₂ : IsSelfAdjointExtension (lagrangianCore L) A₂) :
    Dom₁ = Dom₂ ∧ ∀ (x : F) (h : x ∈ Dom₁) (h' : x ∈ Dom₂), A₁ ⟨x, h⟩ = A₂ ⟨x, h'⟩ :=
  isSelfAdjointExtension_unique_of_esa hesa h₁ h₂

/-- **The Hashimoto/SIRK shift-invert limit selects the transformed
Navier–Stokes generator.**  The Lagrangian counterpart of
`BookProof.NavierStokesFlow.NSHashimoto.ns_hashimoto_selects`; combined with
`hFull_essentiallySelfAdjointOn` it is proved from the Kato–Rellich step of this
module and is therefore independent of the Eulerian chain. -/
theorem lagrangian_hashimoto_selects
    (hesa : EssentiallySelfAdjointOn L.D (lagrangianCore L))
    (bas : HilbertBasis ℕ ℂ F) (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (X : ℕ → F →L[ℂ] F),
      IsSelfAdjointExtension (lagrangianCore L) A ∧
      (∀ j, IsShiftInvertC A (γ j) (X j)) ∧
      (∀ j, ‖X j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j, Dom = LinearMap.range ((X j : F →ₗ[ℂ] F))) ∧
      (∀ j k u, X j u - X k u = (γ k - γ j) • X j (X k u)) ∧
      (∀ j k, X j ∘L X k = X k ∘L X j) ∧
      (∀ j m, X j ∘L (ContinuousLinearMap.id ℂ F - (γ m - γ j) • X m) = X m) ∧
      (∀ m v k, sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k) = (X m ^ k) v) ∧
      (∀ j u, Tendsto (fun n : ℕ => galerkinCompression (X j) bas n u) atTop (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ F) (A' : Dom' →ₗ[ℂ] F), IsShiftInvertC A' (γ j) (X j) →
        Dom' = Dom ∧ ∀ (x : F) (hx : x ∈ Dom) (hx' : x ∈ Dom'), A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  hashimoto_multishift_selects_esa bas (lagrangianCore L) L.dense
    (lagrangianCore_symmetricOn L) hesa γ hγ

/-- **The single-shift form.** -/
theorem lagrangian_shiftInvert_selects
    (hesa : EssentiallySelfAdjointOn L.D (lagrangianCore L)) {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (X : F →L[ℂ] F),
      IsSelfAdjointExtension (lagrangianCore L) A ∧ IsShiftInvertC A γ X ∧
      ‖X‖ ≤ |γ.im|⁻¹ ∧ Dom = LinearMap.range ((X : F →ₗ[ℂ] F)) ∧
      (∀ (Dom' : Submodule ℂ F) (A' : Dom' →ₗ[ℂ] F), IsShiftInvertC A' γ X →
        Dom' = Dom ∧ ∀ (x : F) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          A' ⟨x, hx'⟩ = A ⟨x, hx⟩) := by
  obtain ⟨Dom, A, hA⟩ := lagrangian_selfAdjoint_extension L hesa
  obtain ⟨hext, hsym, hsa⟩ := hA
  obtain ⟨X, hX⟩ := exists_isShiftInvertC hsym hγ (cshiftMap_surjective hsym hsa hγ)
  refine ⟨Dom, A, X, ⟨hext, hsym, hsa⟩, hX, hX.opNorm_le hsym hγ, hX.dom_eq_range, ?_⟩
  intro Dom' A' hA'
  obtain ⟨hdom, hval⟩ := shiftInvertC_determines hA' hX
  exact ⟨hdom, fun x hx hx' => hval x hx' hx⟩

end Selection

/-! ## A genuinely unbounded instance on `ℓ²(ℕ)` -/

section Instance

open LpNat DiagonalEsa

/-- The diagonal operator with zero symbol is the zero operator. -/
theorem diagOp_zero_symbol : diagOp (fun _ => (0 : ℝ)) = 0 := by
  refine LinearMap.ext fun f => Subtype.ext (lp.ext ?_)
  funext n
  simp [diagFun]

/-- Transformed Navier–Stokes data on `ℓ²(ℕ)` whose parcel momenta are the
**unbounded** diagonal operators `Pᵢ = diag(n)`, whose drift generators are those
same momenta (as the Lagrangian picture demands, `Dᵢ = Pᵢ`), with unit force in
each direction, no viscosity and no constraint.  The second-order part is
`diag(3n²/2)` and the drift is `diag(3n)`: an unbounded first-order perturbation
of an unbounded second-order operator. -/
noncomputable def diagKR : LagrangianFullData L2N :=
  diagLagData (fun _ n => (n : ℝ)) (fun _ _ => 0) (fun _ n => (n : ℝ)) (fun _ => 0)
    (fun _ => 1) (le_refl (0 : ℝ))

theorem diagKR_drive : diagKR.drive = diagKR.P := rfl

theorem diagKR_secondOrder :
    secondOrder diagKR = diagOp (fun n => (3 / 2 : ℝ) * (n : ℝ) ^ 2) := by
  simp only [secondOrder, LagrangianFullData.kinetic, LagrangianFullData.viscous, diagKR,
    diagLagData, diagOp_comp, diagOp_sum, diagOp_real_smul, diagOp_add]
  refine congrArg diagOp ?_
  funext n
  simp only [Fin.sum_univ_three]
  ring

theorem diagKR_drift : diagKR.drift = diagOp (fun n => 3 * (n : ℝ)) := by
  simp only [LagrangianFullData.drift, diagKR, diagLagData, diagOp_sum, diagOp_real_smul]
  refine congrArg diagOp ?_
  funext n
  simp only [Fin.sum_univ_three]
  ring

theorem diagKR_constraint_zero : diagKR.constraintOp = 0 := diagOp_zero_symbol

theorem diagKR_constraint_bound (v : diagKR.D) :
    ‖(diagKR.constraintOp v : L2N)‖ ≤ 0 * ‖(v : L2N)‖ := by
  rw [diagKR_constraint_zero]
  simp

theorem diagKR_secondOrder_hasZeroDeficiencyOn :
    HasZeroDeficiencyOn diagKR.D (secondOrder diagKR) := by
  rw [diagKR_secondOrder]
  exact diagOp_hasZeroDeficiencyOn _

/-- **The drift of this instance is not a bounded perturbation**, so the bounded
Kato–Rellich theorem does not apply to it: the relative version is genuinely
needed. -/
theorem diagKR_drift_not_bounded :
    ¬ ∃ C : ℝ, ∀ f : diagKR.D, ‖diagKR.drift f‖ ≤ C * ‖f‖ := by
  rw [diagKR_drift]
  refine diagOp_not_bounded _ fun C => ?_
  refine ⟨⌈|C|⌉₊ + 1, ?_⟩
  have hn : |C| ≤ (⌈|C|⌉₊ : ℝ) := Nat.le_ceil _
  have hc : C ≤ |C| := le_abs_self C
  have h0 : (0 : ℝ) ≤ (⌈|C|⌉₊ : ℝ) := Nat.cast_nonneg _
  have habs : |3 * ((⌈|C|⌉₊ + 1 : ℕ) : ℝ)| = 3 * ((⌈|C|⌉₊ : ℝ) + 1) := by
    push_cast
    rw [abs_of_nonneg (by positivity)]
  rw [habs]
  linarith

/-- **The full transformed Hamiltonian of the unbounded instance is essentially
self-adjoint** — by Kato–Rellich, from the essential self-adjointness of its
positive second-order part alone. -/
theorem diagKR_hFull_essentiallySelfAdjointOn :
    EssentiallySelfAdjointOn diagKR.D (lagrangianCore diagKR) :=
  hFull_essentiallySelfAdjointOn_of_drive_eq_P diagKR diagKR_drive le_rfl
    diagKR_constraint_bound
    ((essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn diagKR.D (secondOrder diagKR)).mpr
      diagKR_secondOrder_hasZeroDeficiencyOn)

theorem diagKR_hFull_hasZeroDeficiencyOn :
    HasZeroDeficiencyOn diagKR.D diagKR.hFull :=
  hFull_hasZeroDeficiencyOn_of_drive_eq_P diagKR diagKR_drive le_rfl diagKR_constraint_bound
    diagKR_secondOrder_hasZeroDeficiencyOn

/-- `ℓ²(ℕ)` carries an `ℕ`-indexed Hilbert basis, so the selection theorem below
is not vacuous. -/
noncomputable def l2NatBasis : HilbertBasis ℕ ℂ L2N :=
  HilbertBasis.ofRepr (LinearIsometryEquiv.refl ℂ L2N)

/-- **The Hashimoto/SIRK selection for the unbounded Lagrangian instance.** -/
theorem diagKR_hashimoto_selects (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ L2N) (A : Dom →ₗ[ℂ] L2N) (X : ℕ → L2N →L[ℂ] L2N),
      IsSelfAdjointExtension (lagrangianCore diagKR) A ∧
      (∀ j, IsShiftInvertC A (γ j) (X j)) ∧
      (∀ j, ‖X j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j, Dom = LinearMap.range ((X j : L2N →ₗ[ℂ] L2N))) ∧
      (∀ j k u, X j u - X k u = (γ k - γ j) • X j (X k u)) ∧
      (∀ j k, X j ∘L X k = X k ∘L X j) ∧
      (∀ j m, X j ∘L (ContinuousLinearMap.id ℂ L2N - (γ m - γ j) • X m) = X m) ∧
      (∀ m v k, sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k) = (X m ^ k) v) ∧
      (∀ j u, Tendsto (fun n : ℕ => galerkinCompression (X j) l2NatBasis n u) atTop
        (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ L2N) (A' : Dom' →ₗ[ℂ] L2N), IsShiftInvertC A' (γ j) (X j) →
        Dom' = Dom ∧ ∀ (x : L2N) (hx : x ∈ Dom) (hx' : x ∈ Dom'), A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  lagrangian_hashimoto_selects diagKR diagKR_hFull_essentiallySelfAdjointOn l2NatBasis γ hγ

end Instance

/-! ## The sharpness record, seen from here -/

section Sharpness

open LpNat JacobiDeficiency

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The zero operator on a dense domain is essentially self-adjoint. -/
theorem hasZeroDeficiencyOn_zero {D : Submodule ℂ F} (hd : Dense (D : Set F)) :
    HasZeroDeficiencyOn D (0 : D →ₗ[ℂ] D) := by
  have key : ∀ w : F, (∀ v : D, (inner ℂ (v : F) w : ℂ) = 0) → w = 0 := by
    intro w hw
    have hclosed : IsClosed {y : F | (inner ℂ y w : ℂ) = 0} :=
      isClosed_eq (Continuous.inner continuous_id continuous_const) continuous_const
    have hsub : (D : Set F) ⊆ {y : F | (inner ℂ y w : ℂ) = 0} := fun y hy => hw ⟨y, hy⟩
    have huniv := hclosed.closure_subset_iff.mpr hsub
    rw [hd.closure_eq] at huniv
    exact inner_self_eq_zero.mp (huniv (Set.mem_univ w))
  constructor <;> intro w hw <;> refine key w fun v => ?_
  · have h := hw v
    simp only [LinearMap.zero_apply, ZeroMemClass.coe_zero, inner_zero_left, inner_smul_right] at h
    exact (mul_eq_zero.mp h.symm).resolve_left Complex.I_ne_zero
  · have h := hw v
    simp only [LinearMap.zero_apply, ZeroMemClass.coe_zero, inner_zero_left, inner_neg_right,
      inner_smul_right] at h
    exact (mul_eq_zero.mp (neg_eq_zero.mp h.symm)).resolve_left Complex.I_ne_zero

/-- In the sharpness example of `BookProof.ChapterNavierStokesLagrangianEsa` —
transformed data whose only nonzero term is an unbounded first-order drift — the
positive second-order part is the **zero** operator. -/
theorem jacobiLag_secondOrder_eq_zero : secondOrder jacobiLagData = 0 := by
  have hP : ∀ i : Fin 3, jacobiLagData.P i = 0 := fun _ => rfl
  have hQ : ∀ i : Fin 3, jacobiLagData.Q i = 0 := fun _ => rfl
  simp [secondOrder, LagrangianFullData.kinetic, LagrangianFullData.viscous, hP, hQ]

/-- **Why the counterexample does not contradict this module.**  In the sharpness
example there is no relative bound of the drift against the parcel momenta: if
there were one, the Kato–Rellich theorem above would apply — the second-order
part is `0`, which is essentially self-adjoint, and the constraint vanishes — and
would make the transformed Hamiltonian essentially self-adjoint, which it is not.
So the hypothesis `hdrift` of `hFull_hasZeroDeficiencyOn` is exactly what rules
the counterexample out. -/
theorem jacobiLag_drift_not_relativelyBounded :
    ¬ ∃ kap kap' : ℝ, 0 ≤ kap ∧ 0 ≤ kap' ∧ ∀ v : jacobiLagData.D,
      ‖(jacobiLagData.drift v : L2N)‖
        ≤ kap * (∑ j : Fin 3, ‖(jacobiLagData.P j v : L2N)‖) + kap' * ‖(v : L2N)‖ := by
  rintro ⟨kap, kap', hkap, hkap', h⟩
  have hC : ∀ v : jacobiLagData.D, ‖(jacobiLagData.constraintOp v : L2N)‖ ≤ 0 * ‖(v : L2N)‖ := by
    intro v
    have hzero : jacobiLagData.constraintOp = 0 := rfl
    rw [hzero]
    simp
  have hT : HasZeroDeficiencyOn jacobiLagData.D (secondOrder jacobiLagData) := by
    rw [jacobiLag_secondOrder_eq_zero]
    exact hasZeroDeficiencyOn_zero jacobiLagData.dense
  have hesa : HasZeroDeficiencyOn jacobiLagData.D jacobiLagData.hFull :=
    hFull_hasZeroDeficiencyOn jacobiLagData hkap hkap' le_rfl h hC hT
  rw [jacobiLagData_hFull] at hesa
  exact jacobiOp_not_hasZeroDeficiencyOn hesa

end Sharpness

end LagrangianKatoRellich

end BookProof.NavierStokesFlow
