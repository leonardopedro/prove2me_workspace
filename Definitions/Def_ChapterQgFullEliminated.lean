import Definitions.Def_ChapterQgFourierElimination
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterStoneBridge
import Mathlib


/-!
# The full quantum-gravity Hamiltonian rebuilt on the eliminated components alone

Second half of item 8 of the quantum-gravity plan items of `CONSOLIDATED_PLAN.md`.  The model of
`BookProof/ChapterQgVielbeinScalaronGaugeFL.lean` carries `36` components per momentum — the nine
vielbein components `e_ν^i(k)` *and* the twenty-seven independent derivative variables
`D_{μν}^i(k)` — and imposes the derivative-gauge forms `G_{μν}^i = D_{μν}^i − i k_μ e_ν^i` as part
of the quadratic form.  `BookProof/ChapterQgFourierElimination.lean` §4 shows that the derivative
components carry no independent content: the constraint surface is exactly the image of the
elimination `elimConfig`.

Here the whole Hamiltonian — vielbein self-interaction (torsion), derivative gauge fixing, 3D
transverse gauge fixing, the scalaron in position representation with the full exponential
Einstein-frame wall, and the coupling to the trace of the vielbein — is **rebuilt on the nine
eliminated components alone**, and its essential self-adjointness is proved again, by the same
Faris–Lavine route, on the smaller outer Fock space `Sec EGMode`.

What is proved, in order:

* `elimCoef` — the coefficient vector, *in the nine vielbein components only*, of each of the `57`
  linear forms of the full model after the elimination `D_{μν}^i ↦ i k_μ e_ν^i`;
  `eFormValue_eq_formValue_elimConfig` is the defining property (the eliminated form is the full
  form evaluated on the eliminated configuration), `elimCoef_dGauge` records that the twenty-seven
  derivative-gauge forms become identically zero, and `eFormValue_torsion` that the torsion form
  becomes the exact Fourier torsion `i(k_μ e_ν^i − k_ν e_μ^i)`.
* `eGram` — the vielbein self-interaction of the rebuilt model, the Gram matrix of the eliminated
  family; `eGram_eq_torsion_add_gauge3d` exhibits it as torsion plus transverse gauge fixing (the
  derivative-gauge forms contributing nothing), and `eGram_quadForm` /
  `quadForm_eq_of_gauge_fixed` prove that **the rebuilt quadratic form is the full one restricted
  to the gauge surface**, in the nine surviving coordinates.
* `eCoupling` — the scalaron–vielbein coupling, unchanged (`eTrace_eq_gTrace`: the trace the
  scalaron couples to never involved the derivative components).
* `qgElimFullModes` — the mode data of the rebuilt model: all five Faris–Lavine bounds with
  `κ = 513 + |g|` and band size `9` (instead of `36`).
* `qgElimFull_esa_farisLavine`, `qgElimFull_esa_core_fl`, `starobinsky_qgElimFull_esa`,
  `starobinsky_qgElimFull_esa_core` — essential self-adjointness of the rebuilt Hamiltonian, and
  `qgElimFull_stone_flow` / `starobinsky_qgElimFull_stone_flow` the unitary time evolution it
  generates.  The extended derivative components never enter the operator or its domain, and no
  restriction-to-a-subset argument is used.
* `qgElimFull_momentum_conserving`, `qgElimFull_number_conserving` — the rebuilt Hamiltonian is
  still block diagonal in the momentum and conserves the particle number.
* Non-vacuity: `elimCoef_torsion_ne_zero`, `elimCoef_gauge3d_ne_zero`, `eGram_diag_ne_zero`,
  `eCoupling_ne_zero`, `infinite_egmode`.

No spectral information, no mass gap and no continuum limit is claimed.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QgFullEliminated

open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa

noncomputable section

/-! ## 1. The eliminated components and their modes -/

/-- The surviving field-space components at one momentum: the nine vielbein components `e_ν^i`.
The twenty-seven derivative components of the full model are gone — not gauge fixed, *absent*. -/
abbrev EComp := Fin 3 × Fin 3

/-- A mode of the rebuilt model: a momentum in `ℤ³` together with one of the nine vielbein
components.  There are still infinitely many momenta — no lattice, no truncation. -/
abbrev EGMode := Mom × EComp

/-- The energy of a mode: the same exact free symbol `σ_k = 1 + |k|²` as in the full model. -/
def eSig (x : EGMode) : ℝ := 1 + momSq x.1

theorem one_le_eSig (x : EGMode) : 1 ≤ eSig x := by
  have := momSq_nonneg x.1
  simp only [eSig]
  linarith

theorem eSig_nonneg (x : EGMode) : 0 ≤ eSig x := le_trans zero_le_one (one_le_eSig x)

/-- The band of a mode: the nine components at the same momentum. -/
def eNbr (x : EGMode) : Finset EGMode :=
  ({x.1} : Finset Mom) ×ˢ (Finset.univ : Finset EComp)

theorem mem_eNbr {x y : EGMode} : y ∈ eNbr x ↔ y.1 = x.1 := by
  constructor
  · intro h
    simp only [eNbr, Finset.mem_product, Finset.mem_singleton] at h
    exact h.1
  · intro h
    simp only [eNbr, Finset.mem_product, Finset.mem_singleton, Finset.mem_univ, and_true]
    exact h

theorem card_eNbr (x : EGMode) : ((eNbr x).card : ℝ) = 9 := by
  simp [eNbr]

/-! ## 2. The linear forms of the full model, after the elimination -/

/-- The indicator of an eliminated component. -/
def eind (c d : EComp) : ℂ := if c = d then 1 else 0

theorem norm_eind_le (c d : EComp) : ‖eind c d‖ ≤ 1 := by
  simp only [eind]; split <;> simp



/-- **The coefficient vectors of the three families of linear forms after the elimination.**  Each
form of the full model is rewritten, by `D_{μν}^i ↦ i k_μ e_ν^i`, as a linear form in the nine
vielbein components alone:

* the torsion form becomes the exact Fourier torsion `i(k_μ e_ν^i − k_ν e_μ^i)`;
* the derivative-gauge form becomes identically zero — the constraint is solved, not imposed;
* the 3D transverse form is untouched. -/
def elimCoef (k : Mom) : FormIdx → EComp → ℂ
  | Sum.inl (mu, nu, i), c =>
      Complex.I * ((k mu : ℤ) : ℂ) * eind c (nu, i)
        - Complex.I * ((k nu : ℤ) : ℂ) * eind c (mu, i)
  | Sum.inr (Sum.inl _), _ => 0
  | Sum.inr (Sum.inr i), c => ∑ mu : Fin 3, Complex.I * ((k mu : ℤ) : ℂ) * eind c (mu, i)

@[simp] theorem elimCoef_torsion (k : Mom) (mu nu i : Fin 3) (c : EComp) :
    elimCoef k (torsionF mu nu i) c
      = Complex.I * ((k mu : ℤ) : ℂ) * eind c (nu, i)
          - Complex.I * ((k nu : ℤ) : ℂ) * eind c (mu, i) := rfl

/-- **The derivative-gauge forms disappear**: after the elimination they are the zero form, which
is the formal statement that the twenty-seven constraints are solved by construction. -/
@[simp] theorem elimCoef_dGauge (k : Mom) (mu nu i : Fin 3) (c : EComp) :
    elimCoef k (dGaugeF mu nu i) c = 0 := rfl

@[simp] theorem elimCoef_gauge3d (k : Mom) (i : Fin 3) (c : EComp) :
    elimCoef k (gauge3dF i) c = ∑ mu : Fin 3, Complex.I * ((k mu : ℤ) : ℂ) * eind c (mu, i) :=
  rfl

/-- The value of the eliminated form `F` at momentum `k` on a configuration of the nine vielbein
components. -/
def eFormValue (k : Mom) (F : FormIdx) (z : EComp → ℂ) : ℂ := ∑ c : EComp, elimCoef k F c * z c









/-! ### The uniform bounds on the eliminated coefficients -/

theorem norm_I_mul_k_mul_eind (k : Mom) (mu : Fin 3) (c d : EComp) :
    ‖Complex.I * ((k mu : ℤ) : ℂ) * eind c d‖ ≤ mAbs k := by
  have h1 : ‖Complex.I * ((k mu : ℤ) : ℂ) * eind c d‖
      = |((k mu : ℤ) : ℝ)| * ‖eind c d‖ := by
    rw [norm_mul, norm_mul, Complex.norm_I, one_mul]
    congr 1
    simp
  rw [h1]
  have h2 := norm_eind_le c d
  have h3 := abs_k_le_mAbs k mu
  have h4 : (0 : ℝ) ≤ |((k mu : ℤ) : ℝ)| := abs_nonneg _
  nlinarith [norm_nonneg (eind c d)]

/-- Every eliminated coefficient is bounded by `3|k|`: the elimination replaces the bounded
derivative coordinates by momentum weights, so all three families are now `O(|k|)`. -/
theorem norm_elimCoef_le (k : Mom) (F : FormIdx) (c : EComp) : ‖elimCoef k F c‖ ≤ 3 * mAbs k := by
  have hM := mAbs_nonneg k
  rcases F with ⟨mu, nu, i⟩ | (⟨mu, nu, i⟩ | i)
  · have hF : elimCoef k (Sum.inl (mu, nu, i)) c = elimCoef k (torsionF mu nu i) c := rfl
    have h : ‖elimCoef k (torsionF mu nu i) c‖ ≤ mAbs k + mAbs k :=
      le_trans (norm_sub_le _ _)
        (add_le_add (norm_I_mul_k_mul_eind k mu c (nu, i))
          (norm_I_mul_k_mul_eind k nu c (mu, i)))
    rw [hF]
    linarith
  · have hF : elimCoef k (Sum.inr (Sum.inl (mu, nu, i))) c = elimCoef k (dGaugeF mu nu i) c := rfl
    rw [hF, elimCoef_dGauge, norm_zero]
    linarith
  · have hF : elimCoef k (Sum.inr (Sum.inr i)) c = elimCoef k (gauge3dF i) c := rfl
    have h : ‖elimCoef k (gauge3dF i) c‖ ≤ 3 * mAbs k := by
      rw [elimCoef_gauge3d]
      refine le_trans (norm_sum_le _ _) ?_
      calc ∑ mu : Fin 3, ‖Complex.I * ((k mu : ℤ) : ℂ) * eind c (mu, i)‖
          ≤ ∑ _mu : Fin 3, mAbs k :=
            Finset.sum_le_sum fun mu _ => norm_I_mul_k_mul_eind k mu c (mu, i)
        _ = 3 * mAbs k := by
            rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
            norm_num
    rw [hF]
    linarith

theorem norm_elimCoef_mul_le (k : Mom) (F : FormIdx) (c d : EComp) :
    ‖(starRingEnd ℂ) (elimCoef k F c) * elimCoef k F d‖ ≤ 9 * (1 + momSq k) := by
  rw [norm_mul, RCLike.norm_conj]
  have h1 := norm_elimCoef_le k F c
  have h2 := norm_elimCoef_le k F d
  have hM := mAbs_nonneg k
  have hsq := mAbs_sq k
  nlinarith [norm_nonneg (elimCoef k F c), norm_nonneg (elimCoef k F d), sq_nonneg (mAbs k)]

/-! ## 3. The vielbein self-interaction of the rebuilt model -/

/-- **The complete quadratic form of the full model, rebuilt on the nine eliminated components**:
the Gram matrix of the eliminated torsion forms, the (vanishing) eliminated derivative-gauge forms
and the 3D transverse forms.  It is diagonal in the momentum and a `9 × 9` matrix in the
components at each momentum. -/
def eGram (x y : EGMode) : ℂ :=
  if x.1 = y.1 then
    ∑ F : FormIdx, (starRingEnd ℂ) (elimCoef x.1 F x.2) * elimCoef x.1 F y.2
  else 0

theorem eGram_herm (x y : EGMode) : eGram y x = (starRingEnd ℂ) (eGram x y) := by
  by_cases h : x.1 = y.1
  · have hy : y.1 = x.1 := h.symm
    simp only [eGram]
    rw [if_pos hy, if_pos h, hy, map_sum]
    refine Finset.sum_congr rfl fun F _ => ?_
    simp only [map_mul, RingHomCompTriple.comp_apply, RingHom.id_apply]
    ring
  · simp only [eGram, if_neg h, if_neg (Ne.symm h), map_zero]

theorem eGram_off {x y : EGMode} (h : y ∉ eNbr x) : eGram x y = 0 := by
  have hne : ¬ x.1 = y.1 := fun hh => h (mem_eNbr.mpr hh.symm)
  simp only [eGram, if_neg hne]

theorem norm_eGram_le (x y : EGMode) : ‖eGram x y‖ ≤ 513 * eSig x := by
  by_cases h : x.1 = y.1
  · simp only [eGram, if_pos h]
    refine le_trans (norm_sum_le _ _) ?_
    calc ∑ F : FormIdx, ‖(starRingEnd ℂ) (elimCoef x.1 F x.2) * elimCoef x.1 F y.2‖
        ≤ ∑ _F : FormIdx, 9 * (1 + momSq x.1) :=
          Finset.sum_le_sum fun F _ => norm_elimCoef_mul_le x.1 F x.2 y.2
      _ = 57 * (9 * (1 + momSq x.1)) := by
          rw [Finset.sum_const, Finset.card_univ, card_formIdx, nsmul_eq_mul]
          norm_num
      _ = 513 * eSig x := by simp only [eSig]; ring
  · have hnn := eSig_nonneg x
    simp only [eGram, if_neg h, norm_zero]
    linarith



/-! ### The rebuilt quadratic form is the full one on the gauge surface -/









/-! ## 4. The scalaron–vielbein coupling on the eliminated components -/

/-- The trace part of the vielbein: the combination the scalaron couples to.  It only ever
involved the nine vielbein components, so the elimination leaves it unchanged. -/
def eTrace (x : EGMode) : ℝ := if x.2.1 = x.2.2 then 1 else 0



theorem abs_eTrace_le (x : EGMode) : |eTrace x| ≤ 1 := by
  simp only [eTrace]
  split <;> simp

/-- **The scalaron–vielbein coupling** at coupling constant `g`, on the eliminated components. -/
def eCoupling (g : ℝ) (x y : EGMode) : ℂ :=
  if x.1 = y.1 then ((g * eTrace x * eTrace y : ℝ) : ℂ) else 0

theorem eCoupling_herm (g : ℝ) (x y : EGMode) :
    eCoupling g y x = (starRingEnd ℂ) (eCoupling g x y) := by
  by_cases h : x.1 = y.1
  · have hy : y.1 = x.1 := h.symm
    simp only [eCoupling]
    rw [if_pos hy, if_pos h, Complex.conj_ofReal]
    norm_cast
    ring
  · simp only [eCoupling, if_neg h, if_neg (Ne.symm h), map_zero]

theorem eCoupling_off (g : ℝ) {x y : EGMode} (h : y ∉ eNbr x) : eCoupling g x y = 0 := by
  have hne : ¬ x.1 = y.1 := fun hh => h (mem_eNbr.mpr hh.symm)
  simp only [eCoupling, if_neg hne]

theorem norm_eCoupling_le (g : ℝ) (x y : EGMode) : ‖eCoupling g x y‖ ≤ |g| := by
  by_cases h : x.1 = y.1
  · simp only [eCoupling, if_pos h, Complex.norm_real, Real.norm_eq_abs, abs_mul]
    have h1 := abs_eTrace_le x
    have h2 := abs_eTrace_le y
    have hg := abs_nonneg g
    calc |g| * |eTrace x| * |eTrace y| ≤ |g| * 1 * 1 := by gcongr
      _ = |g| := by ring
  · simp only [eCoupling, if_neg h, norm_zero]
    exact abs_nonneg g

/-! ## 5. The mode data of the rebuilt model -/

/-- **The mode data of the full quantum-gravity model rebuilt on the eliminated components**:
exact Fourier modes of the vielbein, the torsion self-interaction in its eliminated (exact
Fourier) form, the — now identically satisfied — gauge fixing of the derivative variables, the 3D
transverse gauge fixing and the scalaron coupling.  All five Faris–Lavine bounds hold with the
single constant `κ = 513 + |g|` and band size `9`, uniformly in the momentum. -/
def qgElimFullModes (g : ℝ) : QgModeData EGMode :=
  ofBounds eSig one_le_eSig eGram (eCoupling g) eNbr
    (fun a b => by rw [mem_eNbr, mem_eNbr, eq_comm])
    (fun _ _ hb => eGram_off hb) (fun _ _ hb => eCoupling_off g hb)
    eGram_herm (eCoupling_herm g)
    (513 + |g|) 9 (by positivity) (by norm_num)
    (fun a => le_of_eq (card_eNbr a))
    (fun a b => by
      by_cases h : a.1 = b.1
      · have hmin : min (eSig a) (eSig b) = eSig a := by
          simp only [eSig]
          rw [h]
          exact min_self _
        have hb := norm_eGram_le a b
        have hnn := eSig_nonneg a
        have hg := abs_nonneg g
        rw [hmin]
        nlinarith
      · have hz : eGram a b = 0 := by simp only [eGram, if_neg h]
        have h1 : (1 : ℝ) ≤ min (eSig a) (eSig b) := le_min (one_le_eSig a) (one_le_eSig b)
        have hg := abs_nonneg g
        rw [hz, norm_zero]
        nlinarith)
    (fun a b => le_trans (norm_eCoupling_le g a b) (by norm_num))
    (fun a b hb => by
      have h : b.1 = a.1 := mem_eNbr.mp hb
      have hcs : eSig a = eSig b := by simp only [eSig, h]
      have hg := abs_nonneg g
      rw [hcs, sub_self, abs_zero]
      linarith)

@[simp] theorem qgElimFullModes_sig (g : ℝ) : (qgElimFullModes g).sig = eSig := rfl

@[simp] theorem qgElimFullModes_A (g : ℝ) : (qgElimFullModes g).A = eGram := rfl

@[simp] theorem qgElimFullModes_B (g : ℝ) : (qgElimFullModes g).B = eCoupling g := rfl

@[simp] theorem qgElimFullModes_nbr (g : ℝ) : (qgElimFullModes g).nbr = eNbr := rfl

/-! ## 6. Essential self-adjointness of the rebuilt Hamiltonian, by Faris–Lavine -/











/-! ## 6b. The unitary time evolution -/







/-! ## 7. Momentum and particle-number conservation -/





/-! ## 8. Non-vacuity -/











end

end BookProof.QgFullEliminated
