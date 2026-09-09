import Mathlib
import BookProof.ChapterNavierStokesAffineFiberEsa

/-!
# Hopping Hamiltonians with **signed**, non-monotone amplitudes

`BookProof.ChapterNavierStokesShiftHamiltonian` proves the two Faris–Lavine
inequalities for a hopping (shift) Hamiltonian whose amplitude `w` is
*non-negative* and *non-decreasing along the shift*.  Both restrictions are
artefacts of the bookkeeping — they are used only to produce a majorant for the
two terms of `(H x)_β = i(w(s⁻¹β) x_{s⁻¹β} − w(β) x_{sβ})` — and both are
obstacles for the coupled Navier–Stokes symbol:

* a negative amplitude occurs whenever a strain rate or a fiber constant is
  negative, and
* a non-monotone amplitude occurs for the *number-conserving* hoppings
  `a_i† a_k` produced by the antisymmetric (vorticity) part of the velocity
  gradient, whose amplitude `√((β_i+1) β_k)` increases in one coordinate and
  decreases in the other.

This module removes both.  The observation is that the estimates never need the
amplitude itself: they need a **majorant** which is non-negative, monotone along
the shift and dominated by the comparison symbol.  The canonical such majorant
is `¼ σ + K`, which is monotone as soon as the symbol increases along the shift.

## The data

A `SignedHop ι σ` consists of an injective shift `s`, an **arbitrary real**
amplitude `w` with `|w| ≤ ¼ σ + K`, and a constant, non-negative symbol
increment `σ (s β) = σ β + Δ`.  Its `maj` is the majorant `ShiftData` with the
same shift and symbol and amplitude `¼ σ + K`, so all the transport lemmas of
`ShiftData` are available.

## What is proved

* `SignedHop.hopH` — the signed hopping Hamiltonian on the maximal domain of
  the comparison symbol, and `SignedHop.hopH_symmetricOn`;
* `SignedHop.hopH_relative_bound` — `‖Hx‖² ≤ ½‖Nx‖² + 8K²‖x‖²`;
* `SignedHop.hopH_commForm_bound` — `|⟪x, i[H, N]x⟫| ≤ 2Δ(¼+K) ⟪x, Nx⟫`;
* `SignedHop.hopH_essentiallySelfAdjointOn_core` — essential self-adjointness on
  the finite-mode core;
* `listH` and `listH_essentiallySelfAdjointOn_core` — **the instrument**: a
  finite family of signed hops sharing one comparison symbol sums to an operator
  that is again essentially self-adjoint on the finite-mode core;
* `gaffH` and `gaffH_essentiallySelfAdjointOn_core` — the affine fiber
  Hamiltonian `½(π V + V π)` for `V(u) = κ u + c` with **no sign hypothesis at
  all** on `κ` and `c`.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace SignedShift

open LpNat FarisLavine IkebeKato ShiftHamiltonian AffineFiber

variable {ι : Type*}

/-- The data of a hopping term with an **arbitrary real** amplitude: an
injective shift, a real amplitude dominated in absolute value by `¼ σ + K`, and
a constant non-negative increment of the symbol along the shift.  Neither
positivity nor monotonicity of the amplitude is assumed. -/
structure SignedHop (ι : Type*) (sym : ι → ℝ) where
  /-- The shift: the hopping `β ↦ s β`. -/
  shift : ι → ι
  /-- The (signed) hopping amplitude. -/
  amp : ι → ℝ
  /-- The additive constant in the domination of the amplitude by the symbol. -/
  K : ℝ
  /-- The increment of the symbol along the shift. -/
  step : ℝ
  shift_injective : Function.Injective shift
  K_nonneg : 0 ≤ K
  step_nonneg : 0 ≤ step
  sym_ge_one : ∀ β, 1 ≤ sym β
  abs_amp_le : ∀ β, |amp β| ≤ (1 / 4) * sym β + K
  sym_step : ∀ β, sym (shift β) = sym β + step

namespace SignedHop

variable {sym : ι → ℝ} (S : SignedHop ι sym)

/-- The majorant amplitude `¼ σ + K`. -/
noncomputable def bnd (β : ι) : ℝ := (1 / 4) * sym β + S.K

theorem bnd_nonneg (β : ι) : 0 ≤ S.bnd β := le_trans (abs_nonneg _) (S.abs_amp_le β)

theorem bnd_mono (β : ι) : S.bnd β ≤ S.bnd (S.shift β) := by
  simp only [bnd, S.sym_step β]
  linarith [S.step_nonneg]

/-- **The majorant shift data**: the same shift and symbol, with the amplitude
replaced by the majorant `¼ σ + K`, which *is* non-negative and monotone.  All
the transport lemmas of `ShiftData` are used through it. -/
noncomputable def maj : ShiftData ι where
  sym := sym
  shift := S.shift
  amp := S.bnd
  K := S.K
  step := S.step
  shift_injective := S.shift_injective
  amp_nonneg := S.bnd_nonneg
  amp_mono := S.bnd_mono
  K_nonneg := S.K_nonneg
  step_nonneg := S.step_nonneg
  sym_ge_one := S.sym_ge_one
  amp_le := fun _ => le_rfl
  sym_step := S.sym_step

@[simp] theorem maj_sym : S.maj.sym = sym := rfl
@[simp] theorem maj_shift : S.maj.shift = S.shift := rfl
@[simp] theorem maj_amp : S.maj.amp = S.bnd := rfl
@[simp] theorem maj_K : S.maj.K = S.K := rfl
@[simp] theorem maj_step : S.maj.step = S.step := rfl

theorem abs_amp_le_bnd (β : ι) : |S.amp β| ≤ S.bnd β := S.abs_amp_le β

/-! ## The Hamiltonian -/

/-- The coordinates of the signed hopping Hamiltonian:
`(H x)_β = i ( w(s⁻¹β) x_{s⁻¹β} − w(β) x_{sβ} )`, with `w` of arbitrary sign. -/
noncomputable def hFun (X : ι → ℂ) : ι → ℂ :=
  fun β => Complex.I * (S.maj.hop (fun α => (S.amp α : ℂ) * X α) β
    - (S.amp β : ℂ) * X (S.shift β))

/-- The two terms of the Hamiltonian are dominated by the majorant sequence. -/
theorem norm_hFun_le (X : ι → ℂ) (β : ι) :
    ‖S.hFun X β‖ ≤ S.maj.hop (S.maj.ampSeq X) β + S.maj.ampSeq X (S.shift β) := by
  have h1 : ‖S.maj.hop (fun α => (S.amp α : ℂ) * X α) β‖ ≤ S.maj.hop (S.maj.ampSeq X) β := by
    by_cases hb : ∃ α, S.maj.shift α = β
    · obtain ⟨α, rfl⟩ := hb
      rw [ShiftData.hop_shift, ShiftData.hop_shift, norm_mul, Complex.norm_real,
        Real.norm_eq_abs]
      exact mul_le_mul_of_nonneg_right (S.abs_amp_le_bnd α) (norm_nonneg _)
    · rw [ShiftData.hop_eq_zero _ _ hb, ShiftData.hop_eq_zero _ _ hb, norm_zero]
  have h2 : ‖(S.amp β : ℂ) * X (S.shift β)‖ ≤ S.maj.ampSeq X (S.shift β) := by
    rw [norm_mul, Complex.norm_real, Real.norm_eq_abs]
    have hb1 : |S.amp β| * ‖X (S.shift β)‖ ≤ S.bnd β * ‖X (S.shift β)‖ :=
      mul_le_mul_of_nonneg_right (S.abs_amp_le_bnd β) (norm_nonneg _)
    have hb2 : S.bnd β * ‖X (S.shift β)‖ ≤ S.bnd (S.shift β) * ‖X (S.shift β)‖ :=
      mul_le_mul_of_nonneg_right (S.bnd_mono β) (norm_nonneg _)
    exact le_trans hb1 hb2
  calc ‖S.hFun X β‖
      = ‖S.maj.hop (fun α => (S.amp α : ℂ) * X α) β - (S.amp β : ℂ) * X (S.shift β)‖ := by
        simp [hFun]
    _ ≤ ‖S.maj.hop (fun α => (S.amp α : ℂ) * X α) β‖ + ‖(S.amp β : ℂ) * X (S.shift β)‖ :=
        norm_sub_le _ _
    _ ≤ S.maj.hop (S.maj.ampSeq X) β + S.maj.ampSeq X (S.shift β) := by linarith

/-- The pointwise square bound behind the relative bound. -/
theorem normSq_hFun_le (X : ι → ℂ) (β : ι) :
    ‖S.hFun X β‖ ^ 2
      ≤ 2 * S.maj.hop (fun α => (S.maj.ampSeq X α) ^ 2) β
        + 2 * (S.maj.ampSeq X (S.shift β)) ^ 2 := by
  have h1 := norm_hFun_le S X β
  have h2 : 0 ≤ S.maj.hop (S.maj.ampSeq X) β :=
    ShiftData.hop_nonneg S.maj (ShiftData.ampSeq_nonneg S.maj X) β
  have h3 : 0 ≤ S.maj.ampSeq X (S.shift β) := ShiftData.ampSeq_nonneg S.maj X _
  have h4 := mul_self_le_mul_self (norm_nonneg (S.hFun X β)) h1
  rw [ShiftData.hop_sq]
  nlinarith [h4, sq_nonneg (S.maj.hop (S.maj.ampSeq X) β - S.maj.ampSeq X (S.shift β))]

/-- The Hamiltonian maps the maximal domain of the comparison operator into the
Hilbert space. -/
theorem memLp_hFun (x : maxDom sym) : Memℓp (S.hFun ((x : L2I ι) : ι → ℂ)) 2 := by
  refine memLpTwo_of_summable_normSq ?_
  have hS := ShiftData.summable_ampSeq_sq S.maj x
  have hshift : Summable (S.maj.hop fun β => (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2) :=
    ShiftData.summable_hop S.maj hS
  have htail : Summable (fun β => (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) (S.maj.shift β)) ^ 2) :=
    ShiftData.summable_comp_shift S.maj hS
  refine Summable.of_nonneg_of_le (fun β => sq_nonneg _) ?_
    ((hshift.mul_left 2).add (htail.mul_left 2))
  intro β
  exact normSq_hFun_le S _ β

/-- **The signed hopping Hamiltonian**, on the maximal domain of the comparison
operator. -/
noncomputable def hopH : maxDom sym →ₗ[ℂ] L2I ι where
  toFun x := ⟨S.hFun ((x : L2I ι) : ι → ℂ), memLp_hFun S x⟩
  map_add' x y := by
    refine lp.ext (funext fun β => ?_)
    by_cases hb : ∃ α, S.maj.shift α = β
    · obtain ⟨α, rfl⟩ := hb
      simp only [lp.coeFn_add, Pi.add_apply, Submodule.coe_add, hFun, ShiftData.hop_shift]
      ring
    · simp only [lp.coeFn_add, Pi.add_apply, Submodule.coe_add, hFun,
        ShiftData.hop_eq_zero _ _ hb]
      ring
  map_smul' a x := by
    refine lp.ext (funext fun β => ?_)
    by_cases hb : ∃ α, S.maj.shift α = β
    · obtain ⟨α, rfl⟩ := hb
      simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply,
        Submodule.coe_smul, hFun, ShiftData.hop_shift]
      ring
    · simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply,
        Submodule.coe_smul, hFun, ShiftData.hop_eq_zero _ _ hb]
      ring

@[simp] theorem hopH_coe (x : maxDom sym) (β : ι) :
    ((hopH S x : L2I ι) : ι → ℂ) β = S.hFun ((x : L2I ι) : ι → ℂ) β := rfl

/-! ## Symmetry -/

/-- The hopping series `w(β) x̄_β y_{sβ}`. -/
noncomputable def crossA (X Y : ι → ℂ) : ι → ℂ :=
  fun β => (S.amp β : ℂ) * (starRingEnd ℂ) (X β) * Y (S.shift β)

/-- The hopping series `w(β) x̄_{sβ} y_β`. -/
noncomputable def crossB (X Y : ι → ℂ) : ι → ℂ :=
  fun β => (S.amp β : ℂ) * (starRingEnd ℂ) (X (S.shift β)) * Y β

theorem norm_crossA_le (X Y : ι → ℂ) (β : ι) :
    ‖S.crossA X Y β‖ ≤ S.maj.ampSeq X β * ‖Y (S.shift β)‖ := by
  simp only [crossA, norm_mul, Complex.norm_real, Real.norm_eq_abs, RCLike.norm_conj]
  have h : |S.amp β| * ‖X β‖ ≤ S.bnd β * ‖X β‖ :=
    mul_le_mul_of_nonneg_right (S.abs_amp_le_bnd β) (norm_nonneg _)
  exact mul_le_mul_of_nonneg_right h (norm_nonneg _)

theorem norm_crossB_le (X Y : ι → ℂ) (β : ι) :
    ‖S.crossB X Y β‖ ≤ S.maj.ampSeq X (S.shift β) * ‖Y β‖ := by
  simp only [crossB, norm_mul, Complex.norm_real, Real.norm_eq_abs, RCLike.norm_conj]
  have h1 : |S.amp β| * ‖X (S.shift β)‖ ≤ S.bnd (S.shift β) * ‖X (S.shift β)‖ :=
    mul_le_mul_of_nonneg_right (le_trans (S.abs_amp_le_bnd β) (S.bnd_mono β)) (norm_nonneg _)
  exact mul_le_mul_of_nonneg_right h1 (norm_nonneg _)

theorem summable_crossA {X Y : ι → ℂ}
    (hX : Summable fun β => (S.maj.ampSeq X β) ^ 2) (hY : Summable fun β => ‖Y β‖ ^ 2) :
    Summable (S.crossA X Y) := by
  refine Summable.of_norm (Summable.of_nonneg_of_le (fun β => norm_nonneg _) (fun β => ?_)
    ((hX.add (ShiftData.summable_comp_shift S.maj hY)).mul_left (1 / 2)))
  have h := norm_crossA_le S X Y β
  simp only [maj_shift]
  nlinarith [sq_nonneg (S.maj.ampSeq X β - ‖Y (S.shift β)‖),
    ShiftData.ampSeq_nonneg S.maj X β, norm_nonneg (Y (S.shift β)), h]

theorem summable_crossB {X Y : ι → ℂ}
    (hX : Summable fun β => (S.maj.ampSeq X β) ^ 2) (hY : Summable fun β => ‖Y β‖ ^ 2) :
    Summable (S.crossB X Y) := by
  refine Summable.of_norm (Summable.of_nonneg_of_le (fun β => norm_nonneg _) (fun β => ?_)
    (((ShiftData.summable_comp_shift S.maj hX).add hY).mul_left (1 / 2)))
  have h := norm_crossB_le S X Y β
  simp only [maj_shift]
  nlinarith [sq_nonneg (S.maj.ampSeq X (S.shift β) - ‖Y β‖),
    ShiftData.ampSeq_nonneg S.maj X (S.shift β), norm_nonneg (Y β), h]

/-- The coordinatewise form of `⟪Hx, y⟫`. -/
theorem conj_hFun_mul (X Y : ι → ℂ) (β : ι) :
    (starRingEnd ℂ) (S.hFun X β) * Y β
      = -Complex.I * S.maj.hop (S.crossA X Y) β + Complex.I * S.crossB X Y β := by
  have h1 : (starRingEnd ℂ) (S.maj.hop (fun α => (S.amp α : ℂ) * X α) β)
      = S.maj.hop (fun α => (S.amp α : ℂ) * (starRingEnd ℂ) (X α)) β := by
    rw [ShiftData.conj_hop]
    congr 1
    funext α
    simp
  have h2 : S.maj.hop (fun α => (S.amp α : ℂ) * (starRingEnd ℂ) (X α)) β * Y β
      = S.maj.hop (S.crossA X Y) β := by
    rw [ShiftData.hop_mul]
    rfl
  have hexp : (starRingEnd ℂ) (S.hFun X β) * Y β
      = -Complex.I * ((starRingEnd ℂ) (S.maj.hop (fun α => (S.amp α : ℂ) * X α) β) * Y β)
        + Complex.I * ((S.amp β : ℂ) * (starRingEnd ℂ) (X (S.shift β)) * Y β) := by
    simp only [hFun, map_mul, map_sub, Complex.conj_I, Complex.conj_ofReal]
    ring
  rw [hexp, h1, h2]
  rfl

/-- The coordinatewise form of `⟪x, Hy⟫`. -/
theorem conj_mul_hFun (X Y : ι → ℂ) (β : ι) :
    (starRingEnd ℂ) (X β) * S.hFun Y β
      = -Complex.I * S.crossA X Y β + Complex.I * S.maj.hop (S.crossB X Y) β := by
  have h2 : (starRingEnd ℂ) (X β) * S.maj.hop (fun α => (S.amp α : ℂ) * Y α) β
      = S.maj.hop (S.crossB X Y) β := by
    by_cases hb : ∃ α, S.maj.shift α = β
    · obtain ⟨α, rfl⟩ := hb
      rw [ShiftData.hop_shift, ShiftData.hop_shift]
      simp only [crossB, maj_shift]
      ring
    · rw [ShiftData.hop_eq_zero _ _ hb, ShiftData.hop_eq_zero _ _ hb, mul_zero]
  have hexp : (starRingEnd ℂ) (X β) * S.hFun Y β
      = Complex.I * ((starRingEnd ℂ) (X β) * S.maj.hop (fun α => (S.amp α : ℂ) * Y α) β)
        - Complex.I * ((S.amp β : ℂ) * (starRingEnd ℂ) (X β) * Y (S.shift β)) := by
    simp only [hFun]
    ring
  rw [hexp, h2]
  simp only [crossA]
  ring

/-- **The two hopping series compute `⟪Hx, y⟫`.** -/
theorem hasSum_inner_hopH_left (x : maxDom sym) (y : L2I ι) :
    HasSum (fun β => -Complex.I * S.crossA ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ)) β
        + Complex.I * S.crossB ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ)) β)
      (inner ℂ (hopH S x : L2I ι) y) := by
  have hA := summable_crossA S (Y := (y : ι → ℂ)) (ShiftData.summable_ampSeq_sq S.maj x)
    (summable_normSq y)
  have hB := summable_crossB S (Y := (y : ι → ℂ)) (ShiftData.summable_ampSeq_sq S.maj x)
    (summable_normSq y)
  have hgoal := (hA.hasSum.mul_left (-Complex.I)).add (hB.hasSum.mul_left Complex.I)
  have hshift := (((ShiftData.hasSum_hop_iff S.maj).mpr hA.hasSum).mul_left (-Complex.I)).add
    (hB.hasSum.mul_left Complex.I)
  have hinner := lp.hasSum_inner (𝕜 := ℂ) ((hopH S x : L2I ι)) y
  have heq : (fun β => (inner ℂ (((hopH S x : L2I ι) : ι → ℂ) β) ((y : ι → ℂ) β) : ℂ))
      = fun β => -Complex.I * S.maj.hop (S.crossA ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ))) β
          + Complex.I * S.crossB ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ)) β := by
    funext β
    rw [RCLike.inner_apply, hopH_coe, mul_comm]
    exact conj_hFun_mul S _ _ β
  rw [heq] at hinner
  rwa [hshift.unique hinner] at hgoal

/-- **The two hopping series compute `⟪x, Hy⟫`** — the same two series. -/
theorem hasSum_inner_hopH_right (x y : maxDom sym) :
    HasSum (fun β => -Complex.I * S.crossA ((x : L2I ι) : ι → ℂ) (((y : L2I ι) : ι → ℂ)) β
        + Complex.I * S.crossB ((x : L2I ι) : ι → ℂ) (((y : L2I ι) : ι → ℂ)) β)
      (inner ℂ (x : L2I ι) (hopH S y : L2I ι)) := by
  have hA := summable_crossA S (Y := ((y : L2I ι) : ι → ℂ))
    (ShiftData.summable_ampSeq_sq S.maj x) (summable_normSq (y : L2I ι))
  have hB := summable_crossB S (Y := ((y : L2I ι) : ι → ℂ))
    (ShiftData.summable_ampSeq_sq S.maj x) (summable_normSq (y : L2I ι))
  have hgoal := (hA.hasSum.mul_left (-Complex.I)).add (hB.hasSum.mul_left Complex.I)
  have hshift := (hA.hasSum.mul_left (-Complex.I)).add
    (((ShiftData.hasSum_hop_iff S.maj).mpr hB.hasSum).mul_left Complex.I)
  have hinner := lp.hasSum_inner (𝕜 := ℂ) ((x : L2I ι)) ((hopH S y : L2I ι))
  have heq : (fun β => (inner ℂ (((x : L2I ι) : ι → ℂ) β)
        (((hopH S y : L2I ι) : ι → ℂ) β) : ℂ))
      = fun β => -Complex.I * S.crossA ((x : L2I ι) : ι → ℂ) (((y : L2I ι) : ι → ℂ)) β
          + Complex.I * S.maj.hop (S.crossB ((x : L2I ι) : ι → ℂ)
            (((y : L2I ι) : ι → ℂ))) β := by
    funext β
    rw [RCLike.inner_apply, hopH_coe, mul_comm]
    exact conj_mul_hFun S _ _ β
  rw [heq] at hinner
  rwa [hshift.unique hinner] at hgoal

/-- **The signed hopping Hamiltonian is symmetric** on the maximal domain. -/
theorem hopH_symmetricOn : SymmetricOn (maxDom sym) (hopH S) := by
  intro x y
  exact (hasSum_inner_hopH_left S x (y : L2I ι)).unique (hasSum_inner_hopH_right S x y)

/-! ## The first Faris–Lavine inequality -/

/-- **The relative bound**: `‖Hx‖² ≤ ½‖Nx‖² + 8K²‖x‖²`. -/
theorem hopH_relative_bound (x : maxDom sym) :
    ‖(hopH S x : L2I ι)‖ ^ 2
      ≤ (1 / 2) * ‖(diagMax sym x : L2I ι)‖ ^ 2 + (8 * S.K ^ 2) * ‖(x : L2I ι)‖ ^ 2 := by
  have hS := ShiftData.summable_ampSeq_sq S.maj x
  have hshift : Summable (S.maj.hop fun β => (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2) :=
    ShiftData.summable_hop S.maj hS
  have htail : Summable (fun β => (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) (S.maj.shift β)) ^ 2) :=
    ShiftData.summable_comp_shift S.maj hS
  have hbound := (hshift.hasSum.mul_left 2).add (htail.hasSum.mul_left 2)
  have hle : ‖(hopH S x : L2I ι)‖ ^ 2
      ≤ 2 * (∑' β, S.maj.hop (fun α => (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) α) ^ 2) β)
        + 2 * ∑' β, (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) (S.maj.shift β)) ^ 2 := by
    refine hasSum_le (fun β => ?_) (ShiftData.hasSum_normSq (hopH S x : L2I ι)) hbound
    rw [hopH_coe]
    exact normSq_hFun_le S _ β
  have hshifteq : (∑' β, S.maj.hop (fun α => (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) α) ^ 2) β)
      = ∑' β, (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2 :=
    ((ShiftData.hasSum_hop_iff S.maj).mpr hS.hasSum).tsum_eq
  have htaille : (∑' β, (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) (S.maj.shift β)) ^ 2)
      ≤ ∑' β, (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2 :=
    tsum_comp_le_tsum_of_inj hS (fun _ => sq_nonneg _) S.maj.shift_injective
  have hT := ShiftData.tsum_ampSeq_sq_le S.maj x
  rw [hshifteq] at hle
  have hdiag : (diagMax S.maj.sym x : L2I ι) = (diagMax sym x : L2I ι) := rfl
  rw [hdiag] at hT
  have hK : S.maj.K = S.K := rfl
  rw [hK] at hT
  linarith

/-! ## The second Faris–Lavine inequality -/

/-- **The commutator form of the signed hopping Hamiltonian**: the hopping series
`2Δ ∑ w(β) Re(x̄_β x_{sβ})`. -/
theorem hasSum_commForm (x : maxDom sym) :
    HasSum (fun β => 2 * S.step * (S.amp β
        * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
            * ((x : L2I ι) : ι → ℂ) (S.shift β)).re))
      (commForm (hopH S) (diagMax sym) x) := by
  have hL := hasSum_inner_hopH_left S x (diagMax sym x : L2I ι)
  have hIm := Complex.hasSum_im hL
  have hpt : ∀ β, (-Complex.I * S.crossA ((x : L2I ι) : ι → ℂ)
        (((diagMax sym x : L2I ι) : ι → ℂ)) β
      + Complex.I * S.crossB ((x : L2I ι) : ι → ℂ)
        (((diagMax sym x : L2I ι) : ι → ℂ)) β).im
      = -S.step * (S.amp β * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
        * ((x : L2I ι) : ι → ℂ) (S.shift β)).re) := by
    intro β
    simp only [crossA, crossB, diagMax_coe, S.sym_step]
    simp [Complex.add_im, Complex.mul_im, Complex.mul_re]
    ring
  have hIm' : HasSum (fun β => -S.step * (S.amp β
      * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
        * ((x : L2I ι) : ι → ℂ) (S.shift β)).re))
      (inner ℂ (hopH S x : L2I ι) (diagMax sym x : L2I ι) : ℂ).im := by
    refine hIm.congr_fun ?_
    intro β
    exact (hpt β).symm
  have hres := hIm'.mul_left (-2)
  rw [commForm_eq]
  refine hres.congr_fun ?_
  intro β
  ring

/-- **The commutator bound**: `|⟪x, i[H,N]x⟫| ≤ 2Δ(¼ + K) ⟪x, Nx⟫`. -/
theorem hopH_commForm_bound (x : maxDom sym) :
    |commForm (hopH S) (diagMax sym) x|
      ≤ (2 * S.step * (1 / 4 + S.K)) * quadForm (diagMax sym) x := by
  have hus := ShiftData.summable_ampOcc S.maj x
  have hutail : Summable (fun β => S.maj.amp (S.maj.shift β)
      * ‖((x : L2I ι) : ι → ℂ) (S.maj.shift β)‖ ^ 2) :=
    ShiftData.summable_comp_shift S.maj hus
  have hbound : HasSum (fun β => S.step * (S.bnd β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2
      + S.bnd (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2))
      (S.step * ((∑' β, S.maj.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2)
        + ∑' β, S.maj.amp (S.maj.shift β)
          * ‖((x : L2I ι) : ι → ℂ) (S.maj.shift β)‖ ^ 2)) :=
    (hus.hasSum.add hutail.hasSum).mul_left S.step
  have hptle : ∀ β, |2 * S.step * (S.amp β * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
        * ((x : L2I ι) : ι → ℂ) (S.shift β)).re)|
      ≤ S.step * (S.bnd β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2
        + S.bnd (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2) := by
    intro β
    have hstep : 0 ≤ S.step := S.step_nonneg
    have habs : 0 ≤ |S.amp β| := abs_nonneg _
    have hre : |((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
        * ((x : L2I ι) : ι → ℂ) (S.shift β)).re|
        ≤ ‖((x : L2I ι) : ι → ℂ) β‖ * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ := by
      refine le_trans (Complex.abs_re_le_norm _) ?_
      rw [norm_mul, RCLike.norm_conj]
    set R := ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
      * ((x : L2I ι) : ι → ℂ) (S.shift β)).re with hR
    set u := ‖((x : L2I ι) : ι → ℂ) β‖ with hu
    set v := ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ with hv
    have hu0 : 0 ≤ u := norm_nonneg _
    have hv0 : 0 ≤ v := norm_nonneg _
    have hrw : |2 * S.step * (S.amp β * R)| = 2 * S.step * (|S.amp β| * |R|) := by
      rw [show (2 : ℝ) * S.step * (S.amp β * R) = (2 * S.step) * (S.amp β * R) from by ring,
        abs_mul, abs_of_nonneg (by positivity : (0 : ℝ) ≤ 2 * S.step), abs_mul]
    have hA : 2 * S.step * (|S.amp β| * |R|) ≤ 2 * S.step * (|S.amp β| * (u * v)) :=
      mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left hre habs) (by positivity)
    have h2ab : 2 * (u * v) ≤ u ^ 2 + v ^ 2 := by nlinarith [sq_nonneg (u - v)]
    have hB : 2 * S.step * (|S.amp β| * (u * v))
        ≤ S.step * (|S.amp β| * u ^ 2 + |S.amp β| * v ^ 2) := by
      nlinarith [mul_le_mul_of_nonneg_left h2ab
        (show (0 : ℝ) ≤ S.step * |S.amp β| by positivity)]
    have hb1 : |S.amp β| * u ^ 2 ≤ S.bnd β * u ^ 2 :=
      mul_le_mul_of_nonneg_right (S.abs_amp_le_bnd β) (sq_nonneg _)
    have hb2 : |S.amp β| * v ^ 2 ≤ S.bnd (S.shift β) * v ^ 2 :=
      mul_le_mul_of_nonneg_right (le_trans (S.abs_amp_le_bnd β) (S.bnd_mono β)) (sq_nonneg _)
    have hC : S.step * (|S.amp β| * u ^ 2 + |S.amp β| * v ^ 2)
        ≤ S.step * (S.bnd β * u ^ 2 + S.bnd (S.shift β) * v ^ 2) :=
      mul_le_mul_of_nonneg_left (add_le_add hb1 hb2) hstep
    rw [hrw]
    linarith [hA, hB, hC]
  have habs := ShiftData.abs_le_of_hasSum (hasSum_commForm S x) hbound hptle
  have htail : (∑' β, S.maj.amp (S.maj.shift β)
        * ‖((x : L2I ι) : ι → ℂ) (S.maj.shift β)‖ ^ 2)
      ≤ ∑' β, S.maj.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2 :=
    tsum_comp_le_tsum_of_inj hus
      (fun β => mul_nonneg (S.maj.amp_nonneg β) (sq_nonneg _)) S.maj.shift_injective
  have hU := ShiftData.tsum_ampOcc_le S.maj x
  have hdiag : quadForm (diagMax S.maj.sym) x = quadForm (diagMax sym) x := rfl
  rw [hdiag] at hU
  have hK : S.maj.K = S.K := rfl
  rw [hK] at hU
  have hqf : 0 ≤ quadForm (diagMax sym) x :=
    diagMax_quadForm_nonneg _ (fun β => le_trans zero_le_one (S.sym_ge_one β)) x
  refine le_trans habs ?_
  nlinarith [hU, htail, S.step_nonneg, S.K_nonneg]

/-- **A signed hopping Hamiltonian is essentially self-adjoint on the
finite-mode core.** -/
theorem hopH_essentiallySelfAdjointOn_core :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((hopH S).comp (Submodule.inclusion (finiteModes_le_maxDom sym))) :=
  essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds sym
    (fun β => le_trans zero_le_one (S.sym_ge_one β))
    (hopH S) (1 / 2) (8 * S.K ^ 2) (2 * S.step * (1 / 4 + S.K))
    (hopH_symmetricOn S) (by nlinarith [S.step_nonneg, S.K_nonneg])
    (hopH_relative_bound S) (hopH_commForm_bound S)

end SignedHop

/-! ## Finite families of hops sharing one comparison symbol -/

variable {sym : ι → ℝ}

/-- **The Hamiltonian of a finite family of signed hops** sharing one comparison
symbol: the sum of the individual hopping Hamiltonians, on the maximal domain of
the symbol. -/
noncomputable def listH (L : List (SignedHop ι sym)) : maxDom sym →ₗ[ℂ] L2I ι :=
  (L.map SignedHop.hopH).sum

@[simp] theorem listH_nil : listH ([] : List (SignedHop ι sym)) = 0 := rfl

@[simp] theorem listH_cons (S : SignedHop ι sym) (L : List (SignedHop ι sym)) :
    listH (S :: L) = SignedHop.hopH S + listH L := rfl

/-- The sum of the family is symmetric on the maximal domain. -/
theorem listH_symmetricOn (L : List (SignedHop ι sym)) : SymmetricOn (maxDom sym) (listH L) := by
  induction L with
  | nil =>
      intro x y
      simp [listH]
  | cons S L ih =>
      intro x y
      have h₁ := SignedHop.hopH_symmetricOn S x y
      have h₂ := ih x y
      change (inner ℂ (listH (S :: L) x : L2I ι) (y : L2I ι) : ℂ)
        = inner ℂ (x : L2I ι) (listH (S :: L) y : L2I ι)
      simp only [listH_cons, LinearMap.add_apply, inner_add_left, inner_add_right]
      linear_combination h₁ + h₂

/-- The relative bound for the sum, with explicit (existential) constants. -/
theorem listH_relative_bound (L : List (SignedHop ι sym)) :
    ∃ a b : ℝ, 0 ≤ a ∧ 0 ≤ b ∧ ∀ x : maxDom sym,
      ‖(listH L x : L2I ι)‖ ^ 2
        ≤ a * ‖(diagMax sym x : L2I ι)‖ ^ 2 + b * ‖(x : L2I ι)‖ ^ 2 := by
  induction L with
  | nil =>
      refine ⟨0, 0, le_rfl, le_rfl, fun x => ?_⟩
      simp [listH]
  | cons S L ih =>
      obtain ⟨a, b, ha, hb, hbound⟩ := ih
      refine ⟨2 * (1 / 2) + 2 * a, 2 * (8 * S.K ^ 2) + 2 * b, by linarith,
        by nlinarith [sq_nonneg S.K], fun x => ?_⟩
      have h₁ := SignedHop.hopH_relative_bound S x
      have h₂ := hbound x
      have htri : ‖(listH (S :: L) x : L2I ι)‖
          ≤ ‖(SignedHop.hopH S x : L2I ι)‖ + ‖(listH L x : L2I ι)‖ := by
        simp only [listH_cons, LinearMap.add_apply]
        exact norm_add_le _ _
      have hsq : ‖(listH (S :: L) x : L2I ι)‖ ^ 2
          ≤ 2 * ‖(SignedHop.hopH S x : L2I ι)‖ ^ 2 + 2 * ‖(listH L x : L2I ι)‖ ^ 2 := by
        nlinarith [norm_nonneg (listH (S :: L) x : L2I ι),
          norm_nonneg (SignedHop.hopH S x : L2I ι), norm_nonneg (listH L x : L2I ι),
          sq_nonneg (‖(SignedHop.hopH S x : L2I ι)‖ - ‖(listH L x : L2I ι)‖)]
      nlinarith [h₁, h₂, hsq]

/-- The commutator bound for the sum, with an explicit (existential) constant. -/
theorem listH_commForm_bound (L : List (SignedHop ι sym)) (hsym : ∀ β, 1 ≤ sym β) :
    ∃ cst : ℝ, 0 ≤ cst ∧ ∀ x : maxDom sym,
      |commForm (listH L) (diagMax sym) x| ≤ cst * quadForm (diagMax sym) x := by
  induction L with
  | nil =>
      refine ⟨0, le_rfl, fun x => ?_⟩
      have : commForm (listH ([] : List (SignedHop ι sym))) (diagMax sym) x = 0 := by
        simp [commForm, listH]
      rw [this]
      simp
  | cons S L ih =>
      obtain ⟨cst, hcst, hbound⟩ := ih
      refine ⟨2 * S.step * (1 / 4 + S.K) + cst, by nlinarith [S.step_nonneg, S.K_nonneg],
        fun x => ?_⟩
      have h₁ := SignedHop.hopH_commForm_bound S x
      have h₂ := hbound x
      have hadd : commForm (listH (S :: L)) (diagMax sym) x
          = commForm (SignedHop.hopH S) (diagMax sym) x + commForm (listH L) (diagMax sym) x := by
        simpa only [listH_cons] using commForm_add (SignedHop.hopH S) (listH L) (diagMax sym) x
      have hqf : 0 ≤ quadForm (diagMax sym) x :=
        diagMax_quadForm_nonneg _ (fun β => le_trans zero_le_one (hsym β)) x
      rw [hadd]
      refine le_trans (abs_add_le _ _) ?_
      nlinarith [h₁, h₂]

/-- **The instrument.**  A finite family of signed hopping terms sharing one
comparison symbol sums to an operator that is essentially self-adjoint on the
finite-mode core.  No positivity and no monotonicity of the amplitudes is
required. -/
theorem listH_essentiallySelfAdjointOn_core (L : List (SignedHop ι sym)) (hsym : ∀ β, 1 ≤ sym β) :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((listH L).comp (Submodule.inclusion (finiteModes_le_maxDom sym))) := by
  obtain ⟨a, b, _, _, hrel⟩ := listH_relative_bound L
  obtain ⟨cst, hcst, hcomm⟩ := listH_commForm_bound L hsym
  exact essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds sym
    (fun β => le_trans zero_le_one (hsym β)) (listH L) a b cst
    (listH_symmetricOn L) hcst hrel hcomm

/-! ## Matrix entries on a basis vector -/

/-- The coordinates of a signed hop applied to the basis vector at `o`: the
amplitude `w(o)` at the coordinate `s o`, and `−w(γ)` at the coordinate `γ` with
`s γ = o`, times `i`. -/
theorem SignedHop.hFun_single [DecidableEq ι] {sym : ι → ℝ} (S : SignedHop ι sym)
    {X : ι → ℂ} {o : ι} (hX : ∀ α, X α = if α = o then 1 else 0) (γ : ι) :
    S.hFun X γ = Complex.I * ((if γ = S.shift o then (S.amp o : ℂ) else 0)
      - (if S.shift γ = o then (S.amp γ : ℂ) else 0)) := by
  have h2 : (S.amp γ : ℂ) * X (S.shift γ)
      = if S.shift γ = o then (S.amp γ : ℂ) else 0 := by
    rw [hX]
    split <;> simp
  have h1 : S.maj.hop (fun α => (S.amp α : ℂ) * X α) γ
      = if γ = S.shift o then (S.amp o : ℂ) else 0 := by
    by_cases hb : ∃ α, S.shift α = γ
    · obtain ⟨α, rfl⟩ := hb
      have hiff : S.shift α = S.shift o ↔ α = o :=
        ⟨fun h => S.shift_injective h, fun h => by rw [h]⟩
      rw [show S.shift α = S.maj.shift α from rfl, ShiftData.hop_shift, hX]
      by_cases hao : α = o
      · subst hao; simp
      · rw [if_neg hao, mul_zero]
        exact (if_neg (fun h => hao (hiff.mp h))).symm
    · rw [ShiftData.hop_eq_zero _ _ (by simpa using hb)]
      exact (if_neg (fun h => hb ⟨o, h.symm⟩)).symm
  rw [SignedHop.hFun, h1, h2]

/-- The coordinates of the Hamiltonian of a finite family: the sum of the
coordinates of the members. -/
theorem listH_coe {sym : ι → ℝ} (L : List (SignedHop ι sym)) (x : maxDom sym) (γ : ι) :
    ((listH L x : L2I ι) : ι → ℂ) γ
      = (L.map (fun S => S.hFun ((x : L2I ι) : ι → ℂ) γ)).sum := by
  induction L with
  | nil => simp [listH]
  | cons S L ih =>
      rw [listH_cons]
      simp only [LinearMap.add_apply, lp.coeFn_add, Pi.add_apply, List.map_cons,
        List.sum_cons, SignedHop.hopH_coe, ih]

/-! ## The affine fiber field with coefficients of **arbitrary sign**

The affine fiber Hamiltonian `½(π V + V π)` for `V(u) = κ u + c` was built in
`BookProof.ChapterNavierStokesAffineFiberEsa` under `κ ≥ 0` and `c ≥ 0`, and the
sign of `c` was removed by the sign-flip unitary of
`BookProof.ChapterNavierStokesSignFlip`.  The signed instrument above removes
both signs at once: the two hopping amplitudes `(κ/2)√((n+1)(n+2))` and
`(c/√2)√(n+1)` are dominated in absolute value by the comparison symbol built
from `|κ|` and `|c|`, whatever their signs. -/

section GeneralAffine

open HermiteFarisLavine

variable (kap cst : ℝ)

/-- The comparison symbol of the affine fiber field with coefficients of
arbitrary sign: the number operator built from `|κ|` and `|c|`. -/
noncomputable def gsym : ℕ → ℝ := oscSymbol (affMu |kap| |cst|)

theorem gsym_ge_one (n : ℕ) : 1 ≤ gsym kap cst n :=
  oscSymbol_ge_one (by unfold affMu; positivity) n

theorem abs_amp_eq (n : ℕ) : |amp kap n| = amp |kap| n := by
  unfold amp
  rw [abs_mul, abs_of_nonneg (Real.sqrt_nonneg _), abs_div]
  norm_num

theorem abs_shear_eq (n : ℕ) : |shear cst n| = shear |cst| n := by
  unfold shear
  rw [abs_mul, abs_of_nonneg (Real.sqrt_nonneg _), abs_div,
    abs_of_nonneg (Real.sqrt_nonneg 2)]

/-- The `±2`-hopping of the linear part, with a strain rate of arbitrary
sign. -/
noncomputable def gLinHop : SignedHop ℕ (gsym kap cst) where
  shift := fun n => n + 2
  amp := amp kap
  K := |kap| + |cst|
  step := 4 * affMu |kap| |cst|
  shift_injective := fun a b hab => by simpa using hab
  K_nonneg := by positivity
  step_nonneg := by unfold affMu; positivity
  sym_ge_one := gsym_ge_one kap cst
  abs_amp_le := fun n => by
    rw [abs_amp_eq, gsym]
    exact amp_le_affine (abs_nonneg kap) (abs_nonneg cst) n
  sym_step := fun n => oscSymbol_step n

/-- The `±1`-hopping of the constant part, with a constant of arbitrary
sign. -/
noncomputable def gShearHop : SignedHop ℕ (gsym kap cst) where
  shift := fun n => n + 1
  amp := shear cst
  K := |kap| + |cst|
  step := 2 * affMu |kap| |cst|
  shift_injective := fun a b hab => by simpa using hab
  K_nonneg := by positivity
  step_nonneg := by unfold affMu; positivity
  sym_ge_one := gsym_ge_one kap cst
  abs_amp_le := fun n => by
    rw [abs_shear_eq, gsym]
    exact shear_le (abs_nonneg cst) (abs_nonneg kap) n
  sym_step := fun n => by unfold gsym oscSymbol; push_cast; ring

/-- **The affine fiber Hamiltonian for an arbitrary real strain rate and an
arbitrary real constant** `V(u) = κ u + c`, on the maximal domain of the
comparison symbol built from `|κ|` and `|c|`. -/
noncomputable def gaffH : maxDom (gsym kap cst) →ₗ[ℂ] L2I ℕ :=
  listH [gLinHop kap cst, gShearHop kap cst]

theorem gaffH_symmetricOn : SymmetricOn (maxDom (gsym kap cst)) (gaffH kap cst) :=
  listH_symmetricOn _

/-- **No sign hypothesis at all**: for every real `κ` and every real `c` the
affine fiber Hamiltonian is essentially self-adjoint on the finite-mode core. -/
theorem gaffH_essentiallySelfAdjointOn_core :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ)
      ((gaffH kap cst).comp (Submodule.inclusion (finiteModes_le_maxDom (gsym kap cst)))) :=
  listH_essentiallySelfAdjointOn_core _ (gsym_ge_one kap cst)

end GeneralAffine

end SignedShift

end BookProof.NavierStokesFlow
