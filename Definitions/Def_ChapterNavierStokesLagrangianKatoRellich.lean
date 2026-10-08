import Definitions.Def_ChapterKatoRellichRelative
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Definitions.Def_ChapterEsaClosure
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterKatoRellichDeficiency
import Mathlib


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











/-! ### The interpolation inequality -/





ule closes the analytic step that the Lagrangian (parcel) route of the
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





/-! ### The physical case: the drift generators are the parcel momenta -/

s thread was missing.  After the change of variables of
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





end Abstract

/-! ## The Hashimoto/SIRK selection on the Lagrangian side -/

section Selection

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (L : LagrangianFullData F)









end Selection

/-! ## A genuinely unbounded instance on `ℓ²(ℕ)` -/

section Instance

open LpNat DiagonalEsa



/-- Transformed Navier–Stokes data on `ℓ²(ℕ)` whose parcel momenta are the
**unbounded** diagonal operators `Pᵢ = diag(n)`, whose drift generators are those
same momenta (as the Lagrangian picture demands, `Dᵢ = Pᵢ`), with unit force in
each direction, no viscosity and no constraint.  The second-order part is
`diag(3n²/2)` and the drift is `diag(3n)`: an unbounded first-order perturbation
of an unbounded second-order operator. -/
noncomputable def diagKR : LagrangianFullData L2N :=
  diagLagData (fun _ n => (n : ℝ)) (fun _ _ => 0) (fun _ n => (n : ℝ)) (fun _ => 0)
    (fun _ => 1) (le_refl (0 : ℝ))



))su * nheef-aR_  Tendsto (fun n : ℕ => galerkinCompression (X j) l2NatBasis n u) atTop
        (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ L2N) (A' : Dom' →ₗ[ℂ] L2N), IsShiftInvertC· o   simp
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
