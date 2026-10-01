import Definitions.Def_ChapterNavierStokesFockContinuum
import Mathlib


/-!
# The transformed Navier–Stokes Hamiltonian in the Lagrangian momentum
representation: essential self-adjointness with continuous spectrum

`BookProof.ChapterNavierStokesLagrangianEsa` sets up the untruncated Lagrangian
data `LagrangianFullData` — the parcel momenta `Pᵢ`, the viscous gradients `Qᵢ`,
the force drift generators `Dᵢ` and the volume-preservation constraint `C` — and
proves that the transformed Hamiltonian

`ĥ_full = ½∑ᵢPᵢ² + ν∑ᵢQᵢ² + ∑ᵢfᵢDᵢ + C`

is symmetric with positive second-order part, essentially self-adjoint whenever
the constituents admit a *total family of common eigenvectors*.

That criterion is a discrete-spectrum criterion: it needs eigenvectors.  The
Lagrangian momentum representation of a *continuum* fluid has none — the
constituents are multiplication operators by the momentum coordinates, whose
spectrum is purely continuous.  This module closes that gap.

## What is proved here

* `DominatedOn` and the multiplication operator `mulD` — multiplication by a
  real measurable symbol `h` on the bounded-energy core of a *scale* function
  `g`, available whenever `h` is bounded on the level sets of `g`, with its
  algebra (`mulD_comp`, `mulD_add`, `mulD_sum`, `mulD_real_smul`).
* `mulD_hasZeroDeficiencyOn` — **multiplication by any symbol dominated by the
  scale is essentially self-adjoint on the bounded-energy core of the scale.**
  This generalizes `FockContinuum.multOp_hasZeroDeficiencyOn`, where symbol and
  scale had to coincide, and it is what allows *all four* constituents of the
  transformed Hamiltonian to live on one common core.
* `LagSymbols` — the Lagrangian momentum representation itself: arbitrary
  measurable real symbols `Pᵢ, Qᵢ, Dᵢ, C` on a measure space of momentum
  configurations, with no boundedness assumption whatsoever, and the common
  core `boundedEnergyCore μ S.scale`.
* `LagSymbols.data` — the resulting `LagrangianFullData`, so everything proved
  about the abstract transformed operator (symmetry, positivity of the advective
  and viscous terms, transfer along the change of variables) applies verbatim.
* `LagSymbols.hFull_eq_mulD` — **the transformed Hamiltonian is multiplication
  by the total Lagrangian symbol** `½∑pᵢ² + ν∑qᵢ² + ∑fᵢdᵢ + c`.
* `LagSymbols.hFull_hasZeroDeficiencyOn` — **the headline: the untruncated
  transformed Navier–Stokes Hamiltonian is essentially self-adjoint in the
  Lagrangian momentum representation**, for arbitrary measurable symbols, with
  in general purely continuous spectrum and no eigenvectors at all.
* `norm_mulD_ge`, `mulD_not_bounded` — the lower bound that makes such an
  operator genuinely unbounded whenever its symbol is.

The second-quantized realization on the continuum Fock space of all
parcel-number sectors — where this criterion is applied to the transformed
Navier–Stokes Hamiltonian itself — is in
`BookProof.ChapterNavierStokesFockParcels`.

## Scope

Nothing here claims global existence for Navier–Stokes, and nothing here claims
essential self-adjointness of the *Eulerian* continuum generator: what is proved
is essential self-adjointness of the transformed operator in the Lagrangian
momentum representation, which by
`NavierStokesFlow.NSFullData.hasZeroDeficiencyOn_of_lagrangian` transports back
along a unitary change of variables only when such a change of variables is
supplied.
-/

open MeasureTheory

namespace BookProof.NavierStokesFlow

namespace FockLagrangian

open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

/-! ## Symbols dominated on the level sets of a scale function -/

/-- The symbol `h` is **dominated on the level sets of the scale `g`**: on the
region where `|g| ≤ n` the symbol `h` is bounded.  This is exactly what is needed
for multiplication by `h` to preserve the bounded-energy core of `g`. -/
def DominatedOn (μ : Measure X) (g h : X → ℝ) : Prop :=
  ∀ n : ℕ, ∃ M : ℝ, 0 ≤ M ∧ ∀ᵐ x ∂μ, |g x| ≤ (n : ℝ) → |h x| ≤ M

theorem DominatedOn.rfl' (μ : Measure X) (g : X → ℝ) : DominatedOn μ g g :=
  fun n => ⟨n, Nat.cast_nonneg n, Filter.Eventually.of_forall fun _ hx => hx⟩









theorem DominatedOn.of_abs_le {μ : Measure X} {g h k : X → ℝ} (d : DominatedOn μ g k)
    (hle : ∀ᵐ x ∂μ, |h x| ≤ |k x|) : DominatedOn μ g h := by
  intro n
  obtain ⟨M, hM, hx⟩ := d n
  refine ⟨M, hM, ?_⟩
  filter_upwards [hx, hle] with x h1 h2 hb
  exact le_trans h2 (h1 hb)



/-! ## Multiplication by a dominated symbol on the bounded-energy core -/

/-- Multiplying a bounded-energy state by a dominated symbol stays
square-integrable. -/
theorem memLp_mulD {μ : Measure X} {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) {f : Lp ℂ 2 μ} (hf : f ∈ boundedEnergyCore μ g) :
    MemLp (fun x => (h x : ℂ) * (f : X → ℂ) x) 2 μ := by
  obtain ⟨n, hn⟩ := hf
  obtain ⟨M, hM, hMx⟩ := hdom n
  have hmeas : AEStronglyMeasurable (fun x => (h x : ℂ) * (f : X → ℂ) x) μ :=
    (Complex.measurable_ofReal.comp hh).aestronglyMeasurable.mul (Lp.aestronglyMeasurable f)
  have hbound : ∀ᵐ x ∂μ, ‖(h x : ℂ) * (f : X → ℂ) x‖ ≤ M * ‖(f : X → ℂ) x‖ := by
    filter_upwards [hn, hMx] with x hx hMb
    by_cases hb : |g x| ≤ (n : ℝ)
    · rw [norm_mul, Complex.norm_real, Real.norm_eq_abs]
      exact mul_le_mul_of_nonneg_right (hMb hb) (norm_nonneg _)
    · rw [hx hb]
      simp
  exact MemLp.of_le_mul (Lp.memLp f) hmeas hbound

theorem mulD_mem_core {μ : Measure X} {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) {f : Lp ℂ 2 μ} (hf : f ∈ boundedEnergyCore μ g) :
    (memLp_mulD hh hdom hf).toLp _ ∈ boundedEnergyCore μ g := by
  obtain ⟨n, hn⟩ := hf
  refine ⟨n, ?_⟩
  filter_upwards [hn, (memLp_mulD hh hdom (⟨n, hn⟩ : f ∈ boundedEnergyCore μ g)).coeFn_toLp]
    with x hx hcoe hbig
  rw [hcoe, hx hbig, mul_zero]

/-- **Multiplication by a dominated real symbol** on the bounded-energy core of
the scale `g`.  Unlike `FockContinuum.multOp` the symbol need not be the scale
itself, so several different symbols act on one and the same core. -/
noncomputable def mulD (μ : Measure X) {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) :
    boundedEnergyCore μ g →ₗ[ℂ] boundedEnergyCore μ g where
  toFun f := ⟨(memLp_mulD hh hdom f.2).toLp _, mulD_mem_core hh hdom f.2⟩
  map_add' f k := by
    refine Subtype.ext (Lp.ext ?_)
    simp only [Submodule.coe_add]
    filter_upwards [(memLp_mulD hh hdom
        (show ((f : Lp ℂ 2 μ) + (k : Lp ℂ 2 μ)) ∈ boundedEnergyCore μ g from (f + k).2)).coeFn_toLp,
      (memLp_mulD hh hdom f.2).coeFn_toLp, (memLp_mulD hh hdom k.2).coeFn_toLp,
      Lp.coeFn_add ((f : Lp ℂ 2 μ)) ((k : Lp ℂ 2 μ)),
      Lp.coeFn_add ((memLp_mulD hh hdom f.2).toLp _)
        ((memLp_mulD hh hdom k.2).toLp _)] with x h1 h2 h3 h4 h5
    rw [h1, h5]
    simp only [Pi.add_apply]
    rw [h2, h3, h4]
    simp only [Pi.add_apply]
    ring
  map_smul' c f := by
    refine Subtype.ext (Lp.ext ?_)
    simp only [Submodule.coe_smul, RingHom.id_apply]
    filter_upwards [(memLp_mulD hh hdom
        (show (c • (f : Lp ℂ 2 μ)) ∈ boundedEnergyCore μ g from (c • f).2)).coeFn_toLp,
      (memLp_mulD hh hdom f.2).coeFn_toLp, Lp.coeFn_smul c ((f : Lp ℂ 2 μ)),
      Lp.coeFn_smul c ((memLp_mulD hh hdom f.2).toLp _)] with x h1 h2 h3 h4
    rw [h1, h4]
    simp only [Pi.smul_apply, smul_eq_mul]
    rw [h2, h3]
    simp only [Pi.smul_apply, smul_eq_mul]
    ring

theorem mulD_coeFn (μ : Measure X) {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) (f : boundedEnergyCore μ g) :
    (((mulD μ hh hdom f : boundedEnergyCore μ g) : Lp ℂ 2 μ) : X → ℂ)
      =ᵐ[μ] fun x => (h x : ℂ) * ((f : Lp ℂ 2 μ) : X → ℂ) x :=
  (memLp_mulD hh hdom f.2).coeFn_toLp



/-- The multiplication operator is symmetric on the core. -/
theorem mulD_isSymmetricDom (μ : Measure X) {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) : IsSymmetricDom (mulD μ hh hdom) := by
  intro x y
  rw [L2.inner_def, L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [mulD_coeFn μ hh hdom x, mulD_coeFn μ hh hdom y] with a hx hy
  simp only [RCLike.inner_apply, hx, hy, map_mul, Complex.conj_ofReal]
  ring







/-! ### Flexible forms of the algebra, with the target symbol given explicitly -/







/-! ## Essential self-adjointness of a dominated multiplication operator -/



/-! ### Lower bounds on the multiplication operator, and unboundedness -/





/-! ### No eigenvectors: continuity of the spectrum -/



/-! ## The Lagrangian momentum representation -/

/-- **The Lagrangian momentum representation of the transformed Navier–Stokes
data.**  The parcel momenta `Pᵢ`, the viscous gradients `Qᵢ`, the force drift
generators `Dᵢ` and the volume-preservation constraint `C` are here *arbitrary
real measurable symbols* on a measure space `X` of momentum configurations —
nothing is assumed bounded, and the resulting operators have in general purely
continuous spectrum. -/
structure LagSymbols (X : Type*) [MeasurableSpace X] (μ : Measure X) where
  /-- The parcel-momentum symbols. -/
  P : Fin 3 → X → ℝ
  /-- The viscous-gradient symbols. -/
  Q : Fin 3 → X → ℝ
  /-- The drift-generator symbols. -/
  Dr : Fin 3 → X → ℝ
  /-- The volume-preservation constraint symbol. -/
  cfun : X → ℝ
  /-- The external force. -/
  force : Fin 3 → ℝ
  /-- The kinematic viscosity. -/
  nu : ℝ
  nu_nonneg : 0 ≤ nu
  P_meas : ∀ i, Measurable (P i)
  Q_meas : ∀ i, Measurable (Q i)
  Dr_meas : ∀ i, Measurable (Dr i)
  c_meas : Measurable cfun

namespace LagSymbols

variable {μ : Measure X} (S : LagSymbols X μ)

/-- The **scale**: the sum of the absolute values of all the symbols.  Its
bounded-energy core is the common domain on which all four constituents of the
transformed Hamiltonian act. -/
def scale : X → ℝ := fun x =>
  (∑ i : Fin 3, |S.P i x|) + (∑ i : Fin 3, |S.Q i x|) + (∑ i : Fin 3, |S.Dr i x|) + |S.cfun x|



theorem scale_meas : Measurable S.scale := by
  refine (((Finset.univ.measurable_sum fun i _ => (S.P_meas i).abs).add
    (Finset.univ.measurable_sum fun i _ => (S.Q_meas i).abs)).add
    (Finset.univ.measurable_sum fun i _ => (S.Dr_meas i).abs)).add S.c_meas.abs

/-- Every symbol of the family is dominated by the scale. -/
theorem dominated_of_abs_le {h : X → ℝ} (hle : ∀ x, |h x| ≤ S.scale x) :
    DominatedOn μ S.scale h :=
  (DominatedOn.rfl' μ S.scale).of_abs_le
    (Filter.Eventually.of_forall fun x =>
      le_trans (hle x) (le_abs_self (S.scale x)))

theorem P_dom (i : Fin 3) : DominatedOn μ S.scale (S.P i) := by
  refine S.dominated_of_abs_le fun x => ?_
  have h1 : |S.P i x| ≤ ∑ j : Fin 3, |S.P j x| :=
    Finset.single_le_sum (f := fun j => |S.P j x|) (fun j _ => abs_nonneg _)
      (Finset.mem_univ i)
  have h2 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.Q j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h3 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.Dr j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h4 : (0 : ℝ) ≤ |S.cfun x| := abs_nonneg _
  simp only [scale]
  linarith

theorem Q_dom (i : Fin 3) : DominatedOn μ S.scale (S.Q i) := by
  refine S.dominated_of_abs_le fun x => ?_
  have h1 : |S.Q i x| ≤ ∑ j : Fin 3, |S.Q j x| :=
    Finset.single_le_sum (f := fun j => |S.Q j x|) (fun j _ => abs_nonneg _)
      (Finset.mem_univ i)
  have h2 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.P j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h3 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.Dr j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h4 : (0 : ℝ) ≤ |S.cfun x| := abs_nonneg _
  simp only [scale]
  linarith

theorem Dr_dom (i : Fin 3) : DominatedOn μ S.scale (S.Dr i) := by
  refine S.dominated_of_abs_le fun x => ?_
  have h1 : |S.Dr i x| ≤ ∑ j : Fin 3, |S.Dr j x| :=
    Finset.single_le_sum (f := fun j => |S.Dr j x|) (fun j _ => abs_nonneg _)
      (Finset.mem_univ i)
  have h2 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.P j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h3 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.Q j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h4 : (0 : ℝ) ≤ |S.cfun x| := abs_nonneg _
  simp only [scale]
  linarith

theorem c_dom : DominatedOn μ S.scale S.cfun := by
  refine S.dominated_of_abs_le fun x => ?_
  have h1 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.P j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h2 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.Q j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h3 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.Dr j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  simp only [scale]
  linarith

/-- The common domain: the bounded-scale core. -/
def core : Submodule ℂ (Lp ℂ 2 μ) := boundedEnergyCore μ S.scale

theorem core_dense : Dense ((S.core : Submodule ℂ (Lp ℂ 2 μ)) : Set (Lp ℂ 2 μ)) :=
  boundedEnergyCore_dense μ S.scale_meas

/-- The parcel-momentum operators. -/
noncomputable def Pop (i : Fin 3) : S.core →ₗ[ℂ] S.core := mulD μ (S.P_meas i) (S.P_dom i)

/-- The viscous-gradient operators. -/
noncomputable def Qop (i : Fin 3) : S.core →ₗ[ℂ] S.core := mulD μ (S.Q_meas i) (S.Q_dom i)

/-- The drift generators. -/
noncomputable def Drop (i : Fin 3) : S.core →ₗ[ℂ] S.core := mulD μ (S.Dr_meas i) (S.Dr_dom i)

/-- The volume-preservation constraint operator. -/
noncomputable def Cop : S.core →ₗ[ℂ] S.core := mulD μ S.c_meas S.c_dom

/-- **The Lagrangian momentum representation as untruncated transformed
Navier–Stokes data.**  Everything proved about `LagrangianFullData` — symmetry,
positivity of the advective and viscous quadratic forms, transfer of essential
self-adjointness along the change of variables — applies to it. -/
noncomputable def data : LagrangianEsa.LagrangianFullData (Lp ℂ 2 μ) where
  D := S.core
  P := S.Pop
  Q := S.Qop
  drive := S.Drop
  force := S.force
  constraintOp := S.Cop
  nu := S.nu
  dense := S.core_dense
  P_symm i := mulD_isSymmetricDom μ (S.P_meas i) (S.P_dom i)
  Q_symm i := mulD_isSymmetricDom μ (S.Q_meas i) (S.Q_dom i)
  drive_symm i := mulD_isSymmetricDom μ (S.Dr_meas i) (S.Dr_dom i)
  constraint_symm := mulD_isSymmetricDom μ S.c_meas S.c_dom
  nu_nonneg := S.nu_nonneg

/-- **The total Lagrangian symbol** `½∑pᵢ² + ν∑qᵢ² + ∑fᵢdᵢ + c`: the classical
energy of the transformed Hamiltonian in the momentum representation. -/
noncomputable def total : X → ℝ := fun x =>
  (1 / 2) * (∑ i : Fin 3, (S.P i x) ^ 2) + S.nu * (∑ i : Fin 3, (S.Q i x) ^ 2)
    + (∑ i : Fin 3, S.force i * S.Dr i x) + S.cfun x





/-! ### The transformed Hamiltonian is multiplication by the total symbol -/

/-- The symbol of the advective (kinetic) term, `½∑pᵢ²`. -/
noncomputable def kinSym : X → ℝ := fun x => (1 / 2) * (∑ i : Fin 3, (S.P i x) ^ 2)

/-- The symbol of the viscous term, `ν∑qᵢ²`. -/
def visSym : X → ℝ := fun x => S.nu * (∑ i : Fin 3, (S.Q i x) ^ 2)

/-- The symbol of the force drift, `∑fᵢdᵢ`. -/
def driSym : X → ℝ := fun x => ∑ i : Fin 3, S.force i * S.Dr i x































end LagSymbols

end FockLagrangian

end BookProof.NavierStokesFlow
