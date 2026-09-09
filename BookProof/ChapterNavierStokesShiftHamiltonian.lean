import Mathlib
import BookProof.ChapterNavierStokesIkebeKato

/-!
# Shift Hamiltonians and their Faris–Lavine inequalities

`BookProof.ChapterNavierStokesHermiteFarisLavine` proves the two Faris–Lavine
inequalities for the Navier–Stokes fiber Hamiltonian of a *single* degree of
freedom, where the Hamiltonian is the `±2`-shift of `ℓ²(ℕ)`.  The Fock-space
(many-mode) Hamiltonian is a **sum** of such shift operators, one for each field
mode, acting on the occupation-number space `ℓ²(ℕᵈ)`.  This module isolates the
one-mode analysis in a form that does not mention `ℕ` at all, so that it can be
applied to each mode of the many-mode problem separately.

## The abstract data

A `ShiftData ι` consists of

* a symbol `σ ≥ 1` on the index set `ι` (the comparison operator `N` is
  multiplication by `σ`),
* an injective *shift* `s : ι → ι` (for the mode `i` of the Fock space,
  `s α = α + 2eᵢ`: the creation of two quanta in the mode `i`),
* an amplitude `w ≥ 0` with `w β ≤ w (s β)`, dominated by the symbol,
  `w β ≤ ¼ σ β + K`,
* a constant symbol increment along the shift, `σ (s β) = σ β + Δ`.

The associated Hamiltonian is the antisymmetric hopping operator

`(H x)_β = i ( w(s⁻¹β) x_{s⁻¹β} − w(β) x_{s β} )`,

which for the Navier–Stokes fiber is `½(π V + V π) = (iκ/2)(a†² − a²)`.

## What is proved

* `shiftH_symmetricOn` — `H` is symmetric on the maximal domain of `N`;
* `shiftH_relative_bound` — `‖H x‖² ≤ ½‖N x‖² + 8K²‖x‖²`;
* `shiftH_commForm_bound` — `|⟪x, i[H, N]x⟫| ≤ 2Δ(¼ + K) ⟪x, N x⟫`;
* `hasSum_commForm` — the commutator form is the hopping series
  `2Δ ∑ w(β) Re(x̄_β x_{sβ})`, in general non-zero.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace ShiftHamiltonian

open LpNat FarisLavine IkebeKato

/-- The data of an abstract shift Hamiltonian: a comparison symbol `σ ≥ 1`, an
injective shift `s`, and a hopping amplitude `w` dominated by the symbol. -/
structure ShiftData (ι : Type*) where
  /-- The symbol of the comparison operator `N`. -/
  sym : ι → ℝ
  /-- The shift: the hopping `β ↦ s β`. -/
  shift : ι → ι
  /-- The hopping amplitude. -/
  amp : ι → ℝ
  /-- The additive constant in the domination of the amplitude by the symbol. -/
  K : ℝ
  /-- The increment of the symbol along the shift. -/
  step : ℝ
  shift_injective : Function.Injective shift
  amp_nonneg : ∀ β, 0 ≤ amp β
  amp_mono : ∀ β, amp β ≤ amp (shift β)
  K_nonneg : 0 ≤ K
  step_nonneg : 0 ≤ step
  sym_ge_one : ∀ β, 1 ≤ sym β
  amp_le : ∀ β, amp β ≤ (1 / 4) * sym β + K
  sym_step : ∀ β, sym (shift β) = sym β + step

variable {ι : Type*} (S : ShiftData ι)

namespace ShiftData

theorem sym_nonneg (β : ι) : 0 ≤ S.sym β := le_trans zero_le_one (S.sym_ge_one β)

/-- The amplitude is dominated by a multiple of the symbol (which is `≥ 1`). -/
theorem amp_le_symbol (β : ι) : S.amp β ≤ (1 / 4 + S.K) * S.sym β := by
  have h1 := S.amp_le β
  have h2 := S.sym_ge_one β
  nlinarith [S.K_nonneg]

/-! ## Transporting a sequence along the shift -/

/-- `S.hop g` is `g` transported along the shift: it is `g α` at `s α` and `0`
off the range of the shift. -/
noncomputable def hop {M : Type*} [Zero M] (g : ι → M) : ι → M :=
  Function.extend S.shift g 0

@[simp] theorem hop_shift {M : Type*} [Zero M] (g : ι → M) (α : ι) :
    S.hop g (S.shift α) = g α :=
  S.shift_injective.extend_apply g 0 α

theorem hop_eq_zero {M : Type*} [Zero M] (g : ι → M) {β : ι} (h : ¬ ∃ α, S.shift α = β) :
    S.hop g β = 0 := by
  change Function.extend S.shift g (0 : ι → M) β = 0
  rw [Function.extend_apply' g (0 : ι → M) β h]
  rfl

theorem hop_comp {M : Type*} [Zero M] (g : ι → M) : (S.hop g) ∘ S.shift = g :=
  funext fun α => hop_shift S g α

theorem hasSum_hop_iff {M : Type*} [AddCommMonoid M] [TopologicalSpace M] {g : ι → M} {a : M} :
    HasSum (S.hop g) a ↔ HasSum g a := by
  have h := S.shift_injective.hasSum_iff (f := S.hop g) (a := a) (fun β hβ => by
    refine hop_eq_zero S g ?_
    rintro ⟨α, rfl⟩
    exact hβ ⟨α, rfl⟩)
  rw [hop_comp] at h
  exact h.symm

theorem summable_hop {M : Type*} [AddCommGroup M] [UniformSpace M] [IsUniformAddGroup M]
    [CompleteSpace M] {g : ι → M} (h : Summable g) : Summable (S.hop g) :=
  ((hasSum_hop_iff S).mpr h.hasSum).summable

theorem summable_comp_shift {g : ι → ℝ} (h : Summable g) : Summable fun β => g (S.shift β) :=
  h.comp_injective S.shift_injective

theorem hop_nonneg {g : ι → ℝ} (h : ∀ α, 0 ≤ g α) (β : ι) : 0 ≤ S.hop g β := by
  by_cases hb : ∃ α, S.shift α = β
  · obtain ⟨α, rfl⟩ := hb
    rw [hop_shift]
    exact h α
  · rw [hop_eq_zero S g hb]

theorem hop_sq (g : ι → ℝ) (β : ι) : S.hop (fun α => g α ^ 2) β = (S.hop g β) ^ 2 := by
  by_cases hb : ∃ α, S.shift α = β
  · obtain ⟨α, rfl⟩ := hb
    rw [hop_shift, hop_shift]
  · rw [hop_eq_zero S _ hb, hop_eq_zero S g hb]
    ring

theorem norm_hop (g : ι → ℂ) (β : ι) : ‖S.hop g β‖ = S.hop (fun α => ‖g α‖) β := by
  by_cases hb : ∃ α, S.shift α = β
  · obtain ⟨α, rfl⟩ := hb
    rw [hop_shift, hop_shift]
  · rw [hop_eq_zero S g hb, hop_eq_zero S _ hb, norm_zero]

/-- Multiplying the transported sequence by a function of the index is the
transport of the correspondingly shifted product. -/
theorem hop_mul (g : ι → ℂ) (Y : ι → ℂ) (β : ι) :
    S.hop g β * Y β = S.hop (fun α => g α * Y (S.shift α)) β := by
  by_cases hb : ∃ α, S.shift α = β
  · obtain ⟨α, rfl⟩ := hb
    rw [hop_shift, hop_shift]
  · rw [hop_eq_zero S g hb, hop_eq_zero S _ hb, zero_mul]

theorem mul_hop (g : ι → ℂ) (Y : ι → ℂ) (β : ι) :
    Y β * S.hop g β = S.hop (fun α => Y (S.shift α) * g α) β := by
  by_cases hb : ∃ α, S.shift α = β
  · obtain ⟨α, rfl⟩ := hb
    rw [hop_shift, hop_shift]
  · rw [hop_eq_zero S g hb, hop_eq_zero S _ hb, mul_zero]

theorem conj_hop (g : ι → ℂ) (β : ι) :
    (starRingEnd ℂ) (S.hop g β) = S.hop (fun α => (starRingEnd ℂ) (g α)) β := by
  by_cases hb : ∃ α, S.shift α = β
  · obtain ⟨α, rfl⟩ := hb
    rw [hop_shift, hop_shift]
  · rw [hop_eq_zero S g hb, hop_eq_zero S _ hb, map_zero]

/-! ## The Hamiltonian -/

/-- The coordinates of the shift Hamiltonian:
`(H x)_β = i ( w(s⁻¹β) x_{s⁻¹β} − w(β) x_{sβ} )`. -/
noncomputable def hFun (X : ι → ℂ) : ι → ℂ :=
  fun β => Complex.I * (S.hop (fun α => (S.amp α : ℂ) * X α) β - (S.amp β : ℂ) * X (S.shift β))

/-- The sequence of amplitudes weighted by the state. -/
noncomputable def ampSeq (X : ι → ℂ) : ι → ℝ := fun β => S.amp β * ‖X β‖

theorem ampSeq_nonneg (X : ι → ℂ) (β : ι) : 0 ≤ S.ampSeq X β :=
  mul_nonneg (S.amp_nonneg β) (norm_nonneg _)

theorem norm_hFun_le (X : ι → ℂ) (β : ι) :
    ‖S.hFun X β‖ ≤ S.hop (S.ampSeq X) β + S.ampSeq X (S.shift β) := by
  have hnorm1 : ‖S.hop (fun α => (S.amp α : ℂ) * X α) β‖ = S.hop (S.ampSeq X) β := by
    rw [norm_hop]
    congr 1
    funext α
    rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (S.amp_nonneg α)]
    rfl
  have hnorm2 : ‖(S.amp β : ℂ) * X (S.shift β)‖ ≤ S.ampSeq X (S.shift β) := by
    rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (S.amp_nonneg β)]
    exact mul_le_mul_of_nonneg_right (S.amp_mono β) (norm_nonneg _)
  calc ‖S.hFun X β‖
      = ‖S.hop (fun α => (S.amp α : ℂ) * X α) β - (S.amp β : ℂ) * X (S.shift β)‖ := by
        simp [hFun]
    _ ≤ ‖S.hop (fun α => (S.amp α : ℂ) * X α) β‖ + ‖(S.amp β : ℂ) * X (S.shift β)‖ :=
        norm_sub_le _ _
    _ ≤ S.hop (S.ampSeq X) β + S.ampSeq X (S.shift β) := by rw [hnorm1]; linarith

/-! ## Square summability -/

/-- The squared norm of an `ℓ²` state is the sum of the squared moduli. -/
theorem hasSum_normSq (f : L2I ι) : HasSum (fun k => ‖(f : ι → ℂ) k‖ ^ 2) (‖f‖ ^ 2) := by
  have h := lp.hasSum_norm (p := 2) (E := fun _ : ι => ℂ) (by norm_num) f
  have h2 : ((2 : ℝ≥0∞).toReal) = ((2 : ℕ) : ℝ) := by norm_num
  rw [h2] at h
  simpa [Real.rpow_natCast] using h

theorem norm_diagMax_coe (x : maxDom S.sym) (β : ι) :
    ‖((diagMax S.sym x : L2I ι) : ι → ℂ) β‖ = S.sym β * ‖((x : L2I ι) : ι → ℂ) β‖ := by
  rw [diagMax_coe, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (sym_nonneg S β)]

/-- The comparison series that dominates the amplitudes. -/
theorem hasSum_ampBound (x : maxDom S.sym) :
    HasSum (fun β => (1 / 8) * ‖((diagMax S.sym x : L2I ι) : ι → ℂ) β‖ ^ 2
        + (2 * S.K ^ 2) * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2)
      ((1 / 8) * ‖(diagMax S.sym x : L2I ι)‖ ^ 2 + (2 * S.K ^ 2) * ‖(x : L2I ι)‖ ^ 2) :=
  ((hasSum_normSq _).mul_left _).add ((hasSum_normSq _).mul_left _)

/-- **The amplitude is dominated by the comparison operator**, squared: the
analytic content of the first Faris–Lavine inequality. -/
theorem ampSeq_sq_le (x : maxDom S.sym) (β : ι) :
    (S.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2
      ≤ (1 / 8) * ‖((diagMax S.sym x : L2I ι) : ι → ℂ) β‖ ^ 2
        + (2 * S.K ^ 2) * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2 := by
  have hle := S.amp_le β
  have hamp := S.amp_nonneg β
  have hA2 : S.amp β ^ 2 ≤ (1 / 8) * S.sym β ^ 2 + 2 * S.K ^ 2 := by
    nlinarith [sq_nonneg (S.sym β / 4 - S.K)]
  rw [norm_diagMax_coe S x β]
  simp only [ampSeq]
  nlinarith [hA2, sq_nonneg ‖((x : L2I ι) : ι → ℂ) β‖, norm_nonneg (((x : L2I ι) : ι → ℂ) β)]

theorem summable_ampSeq_sq (x : maxDom S.sym) :
    Summable (fun β => (S.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2) :=
  Summable.of_nonneg_of_le (fun _ => sq_nonneg _) (ampSeq_sq_le S x)
    (hasSum_ampBound S x).summable

theorem tsum_ampSeq_sq_le (x : maxDom S.sym) :
    (∑' β, (S.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2)
      ≤ (1 / 8) * ‖(diagMax S.sym x : L2I ι)‖ ^ 2 + (2 * S.K ^ 2) * ‖(x : L2I ι)‖ ^ 2 := by
  refine le_trans (Summable.tsum_le_tsum (ampSeq_sq_le S x) (summable_ampSeq_sq S x)
    (hasSum_ampBound S x).summable) ?_
  exact le_of_eq (hasSum_ampBound S x).tsum_eq

/-- The Hamiltonian maps the maximal domain of the comparison operator into the
Hilbert space. -/
theorem memLp_hFun (x : maxDom S.sym) : Memℓp (S.hFun ((x : L2I ι) : ι → ℂ)) 2 := by
  refine memLpTwo_of_summable_normSq ?_
  have hS := summable_ampSeq_sq S x
  have hshift : Summable (S.hop fun β => (S.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2) :=
    summable_hop S hS
  have htail : Summable (fun β => (S.ampSeq ((x : L2I ι) : ι → ℂ) (S.shift β)) ^ 2) :=
    summable_comp_shift S hS
  refine Summable.of_nonneg_of_le (fun β => sq_nonneg _) ?_
    ((hshift.mul_left 2).add (htail.mul_left 2))
  intro β
  have h1 := norm_hFun_le S ((x : L2I ι) : ι → ℂ) β
  have h2 : 0 ≤ S.hop (S.ampSeq ((x : L2I ι) : ι → ℂ)) β :=
    hop_nonneg S (ampSeq_nonneg S _) β
  have h3 : 0 ≤ S.ampSeq ((x : L2I ι) : ι → ℂ) (S.shift β) := ampSeq_nonneg S _ _
  have h4 := mul_self_le_mul_self (norm_nonneg (S.hFun ((x : L2I ι) : ι → ℂ) β)) h1
  rw [hop_sq]
  nlinarith [h4, sq_nonneg (S.hop (S.ampSeq ((x : L2I ι) : ι → ℂ)) β
    - S.ampSeq ((x : L2I ι) : ι → ℂ) (S.shift β))]

/-- **The shift Hamiltonian**, on the maximal domain of the comparison
operator. -/
noncomputable def shiftH : maxDom S.sym →ₗ[ℂ] L2I ι where
  toFun x := ⟨S.hFun ((x : L2I ι) : ι → ℂ), memLp_hFun S x⟩
  map_add' x y := by
    refine lp.ext (funext fun β => ?_)
    by_cases hb : ∃ α, S.shift α = β
    · obtain ⟨α, rfl⟩ := hb
      simp only [lp.coeFn_add, Pi.add_apply, Submodule.coe_add, hFun, hop_shift]
      ring
    · simp only [lp.coeFn_add, Pi.add_apply, Submodule.coe_add, hFun,
        hop_eq_zero S _ hb]
      ring
  map_smul' a x := by
    refine lp.ext (funext fun β => ?_)
    by_cases hb : ∃ α, S.shift α = β
    · obtain ⟨α, rfl⟩ := hb
      simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply,
        Submodule.coe_smul, hFun, hop_shift]
      ring
    · simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply,
        Submodule.coe_smul, hFun, hop_eq_zero S _ hb]
      ring

@[simp] theorem shiftH_coe (x : maxDom S.sym) (β : ι) :
    ((shiftH S x : L2I ι) : ι → ℂ) β = S.hFun ((x : L2I ι) : ι → ℂ) β := rfl

/-! ## The inner products of the Hamiltonian

`⟪Hx, y⟫` splits into the two hopping series `A` (a hop along the shift) and `B`
(a hop against it).  Both converge absolutely because `2ab ≤ a² + b²`. -/

/-- The hopping series `w(β) x̄_β y_{sβ}`. -/
noncomputable def crossA (X Y : ι → ℂ) : ι → ℂ :=
  fun β => (S.amp β : ℂ) * (starRingEnd ℂ) (X β) * Y (S.shift β)

/-- The hopping series `w(β) x̄_{sβ} y_β`. -/
noncomputable def crossB (X Y : ι → ℂ) : ι → ℂ :=
  fun β => (S.amp β : ℂ) * (starRingEnd ℂ) (X (S.shift β)) * Y β

theorem norm_crossA (X Y : ι → ℂ) (β : ι) :
    ‖S.crossA X Y β‖ = S.ampSeq X β * ‖Y (S.shift β)‖ := by
  simp only [crossA, ampSeq, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (S.amp_nonneg β), RCLike.norm_conj]

theorem norm_crossB (X Y : ι → ℂ) (β : ι) :
    ‖S.crossB X Y β‖ = S.amp β * ‖X (S.shift β)‖ * ‖Y β‖ := by
  simp only [crossB, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (S.amp_nonneg β), RCLike.norm_conj]

theorem summable_crossA {X Y : ι → ℂ}
    (hX : Summable fun β => (S.ampSeq X β) ^ 2) (hY : Summable fun β => ‖Y β‖ ^ 2) :
    Summable (S.crossA X Y) := by
  refine Summable.of_norm (Summable.of_nonneg_of_le (fun β => norm_nonneg _) (fun β => ?_)
    ((hX.add (summable_comp_shift S hY)).mul_left (1 / 2)))
  rw [norm_crossA S]
  nlinarith [sq_nonneg (S.ampSeq X β - ‖Y (S.shift β)‖), ampSeq_nonneg S X β,
    norm_nonneg (Y (S.shift β))]

theorem summable_crossB {X Y : ι → ℂ}
    (hX : Summable fun β => (S.ampSeq X β) ^ 2) (hY : Summable fun β => ‖Y β‖ ^ 2) :
    Summable (S.crossB X Y) := by
  refine Summable.of_norm (Summable.of_nonneg_of_le (fun β => norm_nonneg _) (fun β => ?_)
    (((summable_comp_shift S hX).add hY).mul_left (1 / 2)))
  rw [norm_crossB S]
  have hmono : S.amp β * ‖X (S.shift β)‖ ≤ S.ampSeq X (S.shift β) :=
    mul_le_mul_of_nonneg_right (S.amp_mono β) (norm_nonneg _)
  have h0 : 0 ≤ ‖Y β‖ := norm_nonneg _
  nlinarith [sq_nonneg (S.ampSeq X (S.shift β) - ‖Y β‖), ampSeq_nonneg S X (S.shift β),
    mul_le_mul_of_nonneg_right hmono h0]

/-- The coordinatewise form of `⟪Hx, y⟫`. -/
theorem conj_hFun_mul (X Y : ι → ℂ) (β : ι) :
    (starRingEnd ℂ) (S.hFun X β) * Y β
      = -Complex.I * S.hop (S.crossA X Y) β + Complex.I * S.crossB X Y β := by
  have h1 : (starRingEnd ℂ) (S.hop (fun α => (S.amp α : ℂ) * X α) β)
      = S.hop (fun α => (S.amp α : ℂ) * (starRingEnd ℂ) (X α)) β := by
    rw [conj_hop]
    congr 1
    funext α
    simp
  have h2 : S.hop (fun α => (S.amp α : ℂ) * (starRingEnd ℂ) (X α)) β * Y β
      = S.hop (S.crossA X Y) β := by
    rw [hop_mul]
    rfl
  have hexp : (starRingEnd ℂ) (S.hFun X β) * Y β
      = -Complex.I * ((starRingEnd ℂ) (S.hop (fun α => (S.amp α : ℂ) * X α) β) * Y β)
        + Complex.I * ((S.amp β : ℂ) * (starRingEnd ℂ) (X (S.shift β)) * Y β) := by
    simp only [hFun, map_mul, map_sub, Complex.conj_I, Complex.conj_ofReal]
    ring
  rw [hexp, h1, h2]
  rfl

/-- The coordinatewise form of `⟪x, Hy⟫`. -/
theorem conj_mul_hFun (X Y : ι → ℂ) (β : ι) :
    (starRingEnd ℂ) (X β) * S.hFun Y β
      = -Complex.I * S.crossA X Y β + Complex.I * S.hop (S.crossB X Y) β := by
  have h2 : (starRingEnd ℂ) (X β) * S.hop (fun α => (S.amp α : ℂ) * Y α) β
      = S.hop (S.crossB X Y) β := by
    by_cases hb : ∃ α, S.shift α = β
    · obtain ⟨α, rfl⟩ := hb
      rw [hop_shift, hop_shift]
      simp only [crossB]
      ring
    · rw [hop_eq_zero S _ hb, hop_eq_zero S _ hb, mul_zero]
  have hexp : (starRingEnd ℂ) (X β) * S.hFun Y β
      = Complex.I * ((starRingEnd ℂ) (X β) * S.hop (fun α => (S.amp α : ℂ) * Y α) β)
        - Complex.I * ((S.amp β : ℂ) * (starRingEnd ℂ) (X β) * Y (S.shift β)) := by
    simp only [hFun]
    ring
  rw [hexp, h2]
  simp only [crossA]
  ring

/-- **The two hopping series compute `⟪Hx, y⟫`.** -/
theorem hasSum_inner_shiftH_left (x : maxDom S.sym) (y : L2I ι) :
    HasSum (fun β => -Complex.I * S.crossA ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ)) β
        + Complex.I * S.crossB ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ)) β)
      (inner ℂ (shiftH S x : L2I ι) y) := by
  have hA := summable_crossA S (Y := (y : ι → ℂ)) (summable_ampSeq_sq S x) (summable_normSq y)
  have hB := summable_crossB S (Y := (y : ι → ℂ)) (summable_ampSeq_sq S x) (summable_normSq y)
  have hgoal := (hA.hasSum.mul_left (-Complex.I)).add (hB.hasSum.mul_left Complex.I)
  have hshift := (((hasSum_hop_iff S).mpr hA.hasSum).mul_left (-Complex.I)).add
    (hB.hasSum.mul_left Complex.I)
  have hinner := lp.hasSum_inner (𝕜 := ℂ) ((shiftH S x : L2I ι)) y
  have heq : (fun β => (inner ℂ (((shiftH S x : L2I ι) : ι → ℂ) β) ((y : ι → ℂ) β) : ℂ))
      = fun β => -Complex.I * S.hop (S.crossA ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ))) β
          + Complex.I * S.crossB ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ)) β := by
    funext β
    rw [RCLike.inner_apply, shiftH_coe, mul_comm]
    exact conj_hFun_mul S _ _ β
  rw [heq] at hinner
  rwa [hshift.unique hinner] at hgoal

/-- **The two hopping series compute `⟪x, Hy⟫`** — the same two series. -/
theorem hasSum_inner_shiftH_right (x y : maxDom S.sym) :
    HasSum (fun β => -Complex.I * S.crossA ((x : L2I ι) : ι → ℂ) (((y : L2I ι) : ι → ℂ)) β
        + Complex.I * S.crossB ((x : L2I ι) : ι → ℂ) (((y : L2I ι) : ι → ℂ)) β)
      (inner ℂ (x : L2I ι) (shiftH S y : L2I ι)) := by
  have hA := summable_crossA S (Y := ((y : L2I ι) : ι → ℂ)) (summable_ampSeq_sq S x)
    (summable_normSq (y : L2I ι))
  have hB := summable_crossB S (Y := ((y : L2I ι) : ι → ℂ)) (summable_ampSeq_sq S x)
    (summable_normSq (y : L2I ι))
  have hgoal := (hA.hasSum.mul_left (-Complex.I)).add (hB.hasSum.mul_left Complex.I)
  have hshift := (hA.hasSum.mul_left (-Complex.I)).add
    (((hasSum_hop_iff S).mpr hB.hasSum).mul_left Complex.I)
  have hinner := lp.hasSum_inner (𝕜 := ℂ) ((x : L2I ι)) ((shiftH S y : L2I ι))
  have heq : (fun β => (inner ℂ (((x : L2I ι) : ι → ℂ) β)
        (((shiftH S y : L2I ι) : ι → ℂ) β) : ℂ))
      = fun β => -Complex.I * S.crossA ((x : L2I ι) : ι → ℂ) (((y : L2I ι) : ι → ℂ)) β
          + Complex.I * S.hop (S.crossB ((x : L2I ι) : ι → ℂ) (((y : L2I ι) : ι → ℂ))) β := by
    funext β
    rw [RCLike.inner_apply, shiftH_coe, mul_comm]
    exact conj_mul_hFun S _ _ β
  rw [heq] at hinner
  rwa [hshift.unique hinner] at hgoal

/-- **The shift Hamiltonian is symmetric** on the maximal domain of the
comparison operator. -/
theorem shiftH_symmetricOn : SymmetricOn (maxDom S.sym) (shiftH S) := by
  intro x y
  exact (hasSum_inner_shiftH_left S x (y : L2I ι)).unique (hasSum_inner_shiftH_right S x y)

/-! ## The first Faris–Lavine inequality: the relative bound -/

/-- The pointwise square bound behind the relative bound. -/
theorem normSq_hFun_le (X : ι → ℂ) (β : ι) :
    ‖S.hFun X β‖ ^ 2
      ≤ 2 * S.hop (fun α => (S.ampSeq X α) ^ 2) β + 2 * (S.ampSeq X (S.shift β)) ^ 2 := by
  have h1 := norm_hFun_le S X β
  have h2 : 0 ≤ S.hop (S.ampSeq X) β := hop_nonneg S (ampSeq_nonneg S X) β
  have h3 : 0 ≤ S.ampSeq X (S.shift β) := ampSeq_nonneg S X _
  have h4 := mul_self_le_mul_self (norm_nonneg (S.hFun X β)) h1
  rw [hop_sq]
  nlinarith [h4, sq_nonneg (S.hop (S.ampSeq X) β - S.ampSeq X (S.shift β))]

/-- **The first Faris–Lavine inequality for a shift Hamiltonian**:
`‖Hx‖² ≤ ½‖Nx‖² + 8K²‖x‖²`. -/
theorem shiftH_relative_bound (x : maxDom S.sym) :
    ‖(shiftH S x : L2I ι)‖ ^ 2
      ≤ (1 / 2) * ‖(diagMax S.sym x : L2I ι)‖ ^ 2 + (8 * S.K ^ 2) * ‖(x : L2I ι)‖ ^ 2 := by
  have hS := summable_ampSeq_sq S x
  have hshift : Summable (S.hop fun β => (S.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2) :=
    summable_hop S hS
  have htail : Summable (fun β => (S.ampSeq ((x : L2I ι) : ι → ℂ) (S.shift β)) ^ 2) :=
    summable_comp_shift S hS
  have hbound := (hshift.hasSum.mul_left 2).add (htail.hasSum.mul_left 2)
  have hle : ‖(shiftH S x : L2I ι)‖ ^ 2
      ≤ 2 * (∑' β, S.hop (fun α => (S.ampSeq ((x : L2I ι) : ι → ℂ) α) ^ 2) β)
        + 2 * ∑' β, (S.ampSeq ((x : L2I ι) : ι → ℂ) (S.shift β)) ^ 2 := by
    refine hasSum_le (fun β => ?_) (hasSum_normSq (shiftH S x : L2I ι)) hbound
    rw [shiftH_coe]
    exact normSq_hFun_le S _ β
  have hshifteq : (∑' β, S.hop (fun α => (S.ampSeq ((x : L2I ι) : ι → ℂ) α) ^ 2) β)
      = ∑' β, (S.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2 :=
    ((hasSum_hop_iff S).mpr hS.hasSum).tsum_eq
  have htaille : (∑' β, (S.ampSeq ((x : L2I ι) : ι → ℂ) (S.shift β)) ^ 2)
      ≤ ∑' β, (S.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2 :=
    tsum_comp_le_tsum_of_inj hS (fun _ => sq_nonneg _) S.shift_injective
  have hT := tsum_ampSeq_sq_le S x
  rw [hshifteq] at hle
  linarith

/-! ## The second Faris–Lavine inequality: the commutator form -/

/-- **The commutator form of a shift Hamiltonian with its comparison operator.**
It is the hopping series `2Δ ∑ w(β) Re(x̄_β x_{sβ})`, in general non-zero. -/
theorem hasSum_commForm (x : maxDom S.sym) :
    HasSum (fun β => 2 * S.step * (S.amp β
        * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
            * ((x : L2I ι) : ι → ℂ) (S.shift β)).re))
      (commForm (shiftH S) (diagMax S.sym) x) := by
  have hL := hasSum_inner_shiftH_left S x (diagMax S.sym x : L2I ι)
  have hIm := Complex.hasSum_im hL
  have hpt : ∀ β, (-Complex.I * S.crossA ((x : L2I ι) : ι → ℂ)
        (((diagMax S.sym x : L2I ι) : ι → ℂ)) β
      + Complex.I * S.crossB ((x : L2I ι) : ι → ℂ)
        (((diagMax S.sym x : L2I ι) : ι → ℂ)) β).im
      = -S.step * (S.amp β * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
        * ((x : L2I ι) : ι → ℂ) (S.shift β)).re) := by
    intro β
    simp only [crossA, crossB, diagMax_coe, S.sym_step]
    simp [Complex.add_im, Complex.mul_im, Complex.mul_re]
    ring
  have hIm' : HasSum (fun β => -S.step * (S.amp β
      * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
        * ((x : L2I ι) : ι → ℂ) (S.shift β)).re))
      (inner ℂ (shiftH S x : L2I ι) (diagMax S.sym x : L2I ι) : ℂ).im := by
    refine hIm.congr_fun ?_
    intro β
    exact (hpt β).symm
  have hres := hIm'.mul_left (-2)
  rw [commForm_eq]
  refine hres.congr_fun ?_
  intro β
  ring

/-- The weighted occupation series `w(β)|x_β|²`, dominated by the quadratic form
of the comparison operator. -/
theorem summable_ampOcc (x : maxDom S.sym) :
    Summable (fun β => S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2) := by
  refine Summable.of_nonneg_of_le (fun β => mul_nonneg (S.amp_nonneg β) (sq_nonneg _))
    (fun β => ?_) ((diagMax_hasSum_quadForm S.sym x).summable.mul_left (1 / 4 + S.K))
  nlinarith [amp_le_symbol S β, sq_nonneg ‖((x : L2I ι) : ι → ℂ) β‖]

theorem tsum_ampOcc_le (x : maxDom S.sym) :
    (∑' β, S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2)
      ≤ (1 / 4 + S.K) * quadForm (diagMax S.sym) x := by
  have hq := diagMax_hasSum_quadForm S.sym x
  refine le_trans (Summable.tsum_le_tsum (fun β => ?_) (summable_ampOcc S x)
    (hq.summable.mul_left (1 / 4 + S.K))) ?_
  · nlinarith [amp_le_symbol S β, sq_nonneg ‖((x : L2I ι) : ι → ℂ) β‖]
  · exact le_of_eq (hq.mul_left (1 / 4 + S.K)).tsum_eq

/-- A series bound gives a bound on the sum. -/
theorem abs_le_of_hasSum {f g : ι → ℝ} {A B : ℝ} (hf : HasSum f A) (hg : HasSum g B)
    (h : ∀ β, |f β| ≤ g β) : |A| ≤ B := by
  refine abs_le.mpr ⟨?_, hasSum_le (fun β => le_trans (le_abs_self _) (h β)) hf hg⟩
  have hneg : HasSum (fun β => -g β) (-B) := hg.neg
  have := hasSum_le (fun β => by linarith [neg_abs_le (f β), h β] : ∀ β, -g β ≤ f β) hneg hf
  linarith

/-- **The second Faris–Lavine inequality for a shift Hamiltonian**:
`|⟪x, i[H,N]x⟫| ≤ 2Δ(¼ + K) ⟪x, Nx⟫`.  Although `[H, N] ≠ 0`, the cross terms it
produces are dominated by the comparison operator, by `2ab ≤ a² + b²`. -/
theorem shiftH_commForm_bound (x : maxDom S.sym) :
    |commForm (shiftH S) (diagMax S.sym) x|
      ≤ (2 * S.step * (1 / 4 + S.K)) * quadForm (diagMax S.sym) x := by
  have hus := summable_ampOcc S x
  have hutail : Summable (fun β => S.amp (S.shift β)
      * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2) :=
    summable_comp_shift S hus
  have hbound : HasSum (fun β => S.step * (S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2
      + S.amp (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2))
      (S.step * ((∑' β, S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2)
        + ∑' β, S.amp (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2)) :=
    (hus.hasSum.add hutail.hasSum).mul_left S.step
  have hptle : ∀ β, |2 * S.step * (S.amp β * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
        * ((x : L2I ι) : ι → ℂ) (S.shift β)).re)|
      ≤ S.step * (S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2
        + S.amp (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2) := by
    intro β
    have hamp : 0 ≤ S.amp β := S.amp_nonneg β
    have hstep : 0 ≤ S.step := S.step_nonneg
    have hre : |((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
        * ((x : L2I ι) : ι → ℂ) (S.shift β)).re|
        ≤ ‖((x : L2I ι) : ι → ℂ) β‖ * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ := by
      refine le_trans (Complex.abs_re_le_norm _) ?_
      rw [norm_mul, RCLike.norm_conj]
    have habs : |2 * S.step * (S.amp β * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
          * ((x : L2I ι) : ι → ℂ) (S.shift β)).re)|
        = 2 * S.step * S.amp β * |((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
          * ((x : L2I ι) : ι → ℂ) (S.shift β)).re| := by
      rw [show (2 : ℝ) * S.step * (S.amp β * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
          * ((x : L2I ι) : ι → ℂ) (S.shift β)).re)
          = (2 * S.step * S.amp β) * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
            * ((x : L2I ι) : ι → ℂ) (S.shift β)).re from by ring, abs_mul,
        abs_of_nonneg (by positivity : (0 : ℝ) ≤ 2 * S.step * S.amp β)]
    have h1 : 2 * S.step * S.amp β * |((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
          * ((x : L2I ι) : ι → ℂ) (S.shift β)).re|
        ≤ 2 * S.step * S.amp β * (‖((x : L2I ι) : ι → ℂ) β‖
          * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖) :=
      mul_le_mul_of_nonneg_left hre (by positivity)
    have hkey : 2 * S.step * S.amp β * (‖((x : L2I ι) : ι → ℂ) β‖
          * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖)
        ≤ S.step * (S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2
          + S.amp β * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2) := by
      have h2ab : 2 * (‖((x : L2I ι) : ι → ℂ) β‖ * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖)
          ≤ ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2 + ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2 := by
        nlinarith [sq_nonneg (‖((x : L2I ι) : ι → ℂ) β‖
          - ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖)]
      have := mul_le_mul_of_nonneg_left h2ab
        (show (0 : ℝ) ≤ S.step * S.amp β by positivity)
      linarith [this]
    have hmono : S.step * (S.amp β * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2)
        ≤ S.step * (S.amp (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2) :=
      mul_le_mul_of_nonneg_left
        (mul_le_mul_of_nonneg_right (S.amp_mono β) (sq_nonneg _)) hstep
    rw [habs]
    linarith
  have habs := abs_le_of_hasSum (hasSum_commForm S x) hbound hptle
  have htail : (∑' β, S.amp (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2)
      ≤ ∑' β, S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2 :=
    tsum_comp_le_tsum_of_inj hus
      (fun β => mul_nonneg (S.amp_nonneg β) (sq_nonneg _)) S.shift_injective
  have hU := tsum_ampOcc_le S x
  have hqf : 0 ≤ quadForm (diagMax S.sym) x :=
    diagMax_quadForm_nonneg _ (sym_nonneg S) x
  refine le_trans habs ?_
  nlinarith [hU, htail, S.step_nonneg, S.K_nonneg]

/-- **A shift Hamiltonian is essentially self-adjoint on the finite-mode core.** -/
theorem shiftH_essentiallySelfAdjointOn_core :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((shiftH S).comp (Submodule.inclusion (finiteModes_le_maxDom S.sym))) :=
  essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds S.sym (sym_nonneg S)
    (shiftH S) (1 / 2) (8 * S.K ^ 2) (2 * S.step * (1 / 4 + S.K))
    (shiftH_symmetricOn S) (by nlinarith [S.step_nonneg, S.K_nonneg])
    (shiftH_relative_bound S) (shiftH_commForm_bound S)

end ShiftData

end ShiftHamiltonian

end BookProof.NavierStokesFlow
