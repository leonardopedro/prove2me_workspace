import Theorems.Thm_BookProof_FockStatistics_bosonicFock_esa
import Theorems.Thm_BookProof_FockStatistics_essentiallySelfAdjointOn_bosonic_core_of_esa
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_esa_on_core
import Definitions.Def_ChapterFockStatisticsEsa
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterEsaOneParticleDGamma
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterQgFourierElimination
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorPermutation
import Mathlib
import Definitions.Def_ChapterQgFourierElimForms
import Theorems.Thm_BookProof_DirectSumEsa_dsCore_dense
import Theorems.Thm_BookProof_QgOuterFockCoreFL_commForm_congr
import Theorems.Thm_BookProof_QgOuterFockCoreFL_quadForm_congr
import Theorems.Thm_BookProof_ScalaronEsa_ccDomain_dense


/-!
# The complete gauge-fixed quantum-gravity Hamiltonian on the symmetrized cores

The QG `secCore` spelling of the work order in `CONSOLIDATED_PLAN.md`.
`BookProof.QgVielbeinScalaronGaugeFL.qgFull_esa_core_fl` proves that the complete gauge-fixed
quantum-gravity one-particle Hamiltonian `secHam W (qgFullModes g)` — vielbein/torsion kinetic
terms, the exact exponential Einstein-frame wall `W` (no Taylor truncation) and the
scalaron–vielbein interaction terms — is essentially self-adjoint on the finite-particle core
`secCore` of `Sec GMode = ℓ²(GMode; L²(ℝ))`.  Here that one-particle statement is carried to
the enclosures:

* **`qgFull_bosonic_core_esa`** — for every particle number `n`, the `n`-particle derivation of
  `secHam` reduced to the **symmetric** tensor power is essentially self-adjoint on the
  symmetrized tensor power of `secCore` (`PermSector.essentiallySelfAdjointOn_bosonic_core`);
* **`qgFull_bosonicFock_esa`**, **`qgFull_hbosonicFock_esa`** — `dΓ(secHam)` is essentially
  self-adjoint on the bosonic Fock space over `secCore` (algebraic, and Hilbert, direct sum of
  the symmetric sectors);
* **`qgFull_dGamma_esa`** — the unsymmetrized enclosure `dΓ(secHam)` (creation left /
  annihilation right, `dGammaCoreOp`) is essentially self-adjoint on the finite-particle domain
  over `secCore`.

No transfer to a Gauss–polynomial core is used or needed: the one-particle core is `secCore`,
built from `C_c^∞` fibres, which is where `qgFull_esa_core_fl` holds.

## Honest boundary

Only the operator `secHam W (qgFullModes g)` of `ChapterQgVielbeinScalaronGaugeFL` is treated;
the 84-dimensional `qg3DHamiltonian` with the Weyl-ordered cross terms (QG-3.2(a)/(b)) is not.
No spectral information and no mass gap is claimed.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.QgSymmetricSector

open scoped TensorProduct
open BookProof.ScalaronOuterFockFL BookProof.QgVielbeinModeInstance
open BookProof.QgContinuumModeInstance BookProof.ScalaronEsa
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.FockStatistics
open BookProof.QgOuterFockCoreFL
open BookProof.QgFourierElim
open BookProof.PermSector BookProof.ReducedEsa BookProof.GroupAverage BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore BookProof.ScalaronFiberFL

noncomputable section

/-- The one-particle space `Sec GMode = ℓ²(GMode; L²(ℝ))`, bundled. -/
def qgSecSpace : IPSpace := ⟨Sec GMode⟩

instance : CompleteSpace qgSecSpace.carrier := inferInstanceAs (CompleteSpace (Sec GMode))

/-! ## 1. The modes of the complete model -/

/-- The energy of a mode: the exact free symbol `σ_k = 1 + |k|²`. -/
def gSig (x : GMode) : ℝ := 1 + momSq x.1

theorem one_le_gSig (x : GMode) : 1 ≤ gSig x := by
  have := momSq_nonneg x.1
  simp only [gSig]
  linarith

theorem gSig_nonneg (x : GMode) : 0 ≤ gSig x := le_trans zero_le_one (one_le_gSig x)

/-- The band of a mode: the thirty-six components at the same momentum.  Momentum
conservation is what makes all the mode matrices banded. -/
def gNbr (x : GMode) : Finset GMode :=
  ({x.1} : Finset Mom) ×ˢ (Finset.univ : Finset Comp)

theorem mem_gNbr {x y : GMode} : y ∈ gNbr x ↔ y.1 = x.1 := by
  constructor
  · intro h
    simp only [gNbr, Finset.mem_product, Finset.mem_singleton] at h
    exact h.1
  · intro h
    simp only [gNbr, Finset.mem_product, Finset.mem_singleton, Finset.mem_univ, and_true]
    exact h

theorem card_gNbr (x : GMode) : ((gNbr x).card : ℝ) = 36 := by
  simp [gNbr]

/-! ## 2. Uniform bounds on the coefficients -/

theorem norm_I_mul_k_mul_ind (k : Mom) (mu : Fin 3) (c d : Comp) :
    ‖Complex.I * ((k mu : ℤ) : ℂ) * ind c d‖ ≤ mAbs k := by
  have h1 : ‖Complex.I * ((k mu : ℤ) : ℂ) * ind c d‖
      = |((k mu : ℤ) : ℝ)| * ‖ind c d‖ := by
    rw [norm_mul, norm_mul, Complex.norm_I, one_mul]
    congr 1
    simp
  rw [h1]
  have h2 := norm_ind_le c d
  have h3 := abs_k_le_mAbs k mu
  have h4 : (0 : ℝ) ≤ |((k mu : ℤ) : ℝ)| := abs_nonneg _
  nlinarith [norm_nonneg (ind c d)]

/-- **The uniform bound on the coefficients**: every coefficient of every one of the three
families is bounded by `2 + 3|k|`. -/
theorem norm_gCoef_le (k : Mom) (F : FormIdx) (c : Comp) : ‖gCoef k F c‖ ≤ 2 + 3 * mAbs k := by
  have hM := mAbs_nonneg k
  rcases F with ⟨mu, nu, i⟩ | (⟨mu, nu, i⟩ | i)
  · have h : ‖gCoef k (torsionF mu nu i) c‖ ≤ 1 + 1 :=
      le_trans (norm_sub_le _ _) (add_le_add (norm_ind_le _ _) (norm_ind_le _ _))
    have : gCoef k (Sum.inl (mu, nu, i)) c = gCoef k (torsionF mu nu i) c := rfl
    rw [this]
    linarith
  · have h : ‖gCoef k (dGaugeF mu nu i) c‖ ≤ 1 + mAbs k :=
      le_trans (norm_sub_le _ _)
        (add_le_add (norm_ind_le _ _) (norm_I_mul_k_mul_ind k mu c (eIdx nu i)))
    have : gCoef k (Sum.inr (Sum.inl (mu, nu, i))) c = gCoef k (dGaugeF mu nu i) c := rfl
    rw [this]
    linarith
  · have h : ‖gCoef k (gauge3dF i) c‖ ≤ 3 * mAbs k := by
      rw [gCoef_gauge3d]
      refine le_trans (norm_sum_le _ _) ?_
      calc ∑ mu : Fin 3, ‖Complex.I * ((k mu : ℤ) : ℂ) * ind c (eIdx mu i)‖
          ≤ ∑ _mu : Fin 3, mAbs k :=
            Finset.sum_le_sum fun mu _ => norm_I_mul_k_mul_ind k mu c (eIdx mu i)
        _ = 3 * mAbs k := by
            rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
            norm_num
    have : gCoef k (Sum.inr (Sum.inr i)) c = gCoef k (gauge3dF i) c := rfl
    rw [this]
    linarith

theorem norm_gCoef_mul_le (k : Mom) (F : FormIdx) (c d : Comp) :
    ‖(starRingEnd ℂ) (gCoef k F c) * gCoef k F d‖ ≤ 15 * (1 + momSq k) := by
  rw [norm_mul, RCLike.norm_conj]
  have h1 := norm_gCoef_le k F c
  have h2 := norm_gCoef_le k F d
  have hM := mAbs_nonneg k
  have hsq := mAbs_sq k
  nlinarith [norm_nonneg (gCoef k F c), norm_nonneg (gCoef k F d), sq_nonneg (mAbs k - 1)]

/-! ## 3. The vielbein self-interaction: the Gram matrix of all three families -/

theorem gGram_herm (x y : GMode) : gGram y x = (starRingEnd ℂ) (gGram x y) := by
  by_cases h : x.1 = y.1
  · have hy : y.1 = x.1 := h.symm
    simp only [gGram]
    rw [if_pos hy, if_pos h, hy, map_sum]
    refine Finset.sum_congr rfl fun F _ => ?_
    simp only [map_mul, RingHomCompTriple.comp_apply, RingHom.id_apply]
    ring
  · simp only [gGram, if_neg h, if_neg (Ne.symm h), map_zero]

theorem gGram_off {x y : GMode} (h : y ∉ gNbr x) : gGram x y = 0 := by
  have hne : ¬ x.1 = y.1 := fun hh => h (mem_gNbr.mpr hh.symm)
  simp only [gGram, if_neg hne]

theorem norm_gGram_le (x y : GMode) : ‖gGram x y‖ ≤ 855 * gSig x := by
  by_cases h : x.1 = y.1
  · simp only [gGram, if_pos h]
    refine le_trans (norm_sum_le _ _) ?_
    calc ∑ F : FormIdx, ‖(starRingEnd ℂ) (gCoef x.1 F x.2) * gCoef x.1 F y.2‖
        ≤ ∑ _F : FormIdx, 15 * (1 + momSq x.1) :=
          Finset.sum_le_sum fun F _ => norm_gCoef_mul_le x.1 F x.2 y.2
      _ = 57 * (15 * (1 + momSq x.1)) := by
          rw [Finset.sum_const, Finset.card_univ, card_formIdx, nsmul_eq_mul]
          norm_num
      _ = 855 * gSig x := by simp only [gSig]; ring
  · have hnn := gSig_nonneg x
    simp only [gGram, if_neg h, norm_zero]
    linarith

/-! ## 4. The scalaron–vielbein coupling -/

/-- The trace part of the vielbein: the combination the scalaron couples to.  The derivative
variables do not carry it. -/
def gTrace (x : GMode) : ℝ :=
  match x.2 with
  | Sum.inl (nu, i) => if nu = i then 1 else 0
  | Sum.inr _ => 0

theorem abs_gTrace_le (x : GMode) : |gTrace x| ≤ 1 := by
  simp only [gTrace]
  rcases x with ⟨k, (⟨nu, i⟩ | ⟨mu, nu, i⟩)⟩
  · dsimp only; split <;> simp
  · simp

/-- **The scalaron–vielbein coupling** at coupling constant `g`: the scalaron field `φ`
multiplied by the trace of the vielbein, at equal momentum. -/
def gCoupling (g : ℝ) (x y : GMode) : ℂ :=
  if x.1 = y.1 then ((g * gTrace x * gTrace y : ℝ) : ℂ) else 0

theorem gCoupling_herm (g : ℝ) (x y : GMode) :
    gCoupling g y x = (starRingEnd ℂ) (gCoupling g x y) := by
  by_cases h : x.1 = y.1
  · have hy : y.1 = x.1 := h.symm
    simp only [gCoupling]
    rw [if_pos hy, if_pos h, Complex.conj_ofReal]
    norm_cast
    ring
  · simp only [gCoupling, if_neg h, if_neg (Ne.symm h), map_zero]

theorem gCoupling_off (g : ℝ) {x y : GMode} (h : y ∉ gNbr x) : gCoupling g x y = 0 := by
  have hne : ¬ x.1 = y.1 := fun hh => h (mem_gNbr.mpr hh.symm)
  simp only [gCoupling, if_neg hne]

theorem norm_gCoupling_le (g : ℝ) (x y : GMode) : ‖gCoupling g x y‖ ≤ |g| := by
  by_cases h : x.1 = y.1
  · simp only [gCoupling, if_pos h, Complex.norm_real, Real.norm_eq_abs, abs_mul]
    have h1 := abs_gTrace_le x
    have h2 := abs_gTrace_le y
    have hg := abs_nonneg g
    calc |g| * |gTrace x| * |gTrace y| ≤ |g| * 1 * 1 := by gcongr
      _ = |g| := by ring
  · simp only [gCoupling, if_neg h, norm_zero]
    exact abs_nonneg g

/-! ## 5. The mode data of the complete model -/

/-- **The mode data of the complete gauge-fixed quantum-gravity model**: exact Fourier modes
of the vielbein together with the independent derivative variables, the torsion
self-interaction, the gauge fixing of the derivative variables, the 3D transverse gauge
fixing and the scalaron coupling.  All five Faris–Lavine bounds hold with the single
constant `κ = 855 + |g|` and band size `36`, uniformly in the momentum. -/
def qgFullModes (g : ℝ) : QgModeData GMode :=
  ofBounds gSig one_le_gSig gGram (gCoupling g) gNbr
    (fun a b => by rw [mem_gNbr, mem_gNbr, eq_comm])
    (fun _ _ hb => gGram_off hb) (fun _ _ hb => gCoupling_off g hb)
    gGram_herm (gCoupling_herm g)
    (855 + |g|) 36 (by positivity) (by norm_num)
    (fun a => le_of_eq (card_gNbr a))
    (fun a b => by
      by_cases h : a.1 = b.1
      · have hmin : min (gSig a) (gSig b) = gSig a := by
          simp only [gSig]
          rw [h]
          exact min_self _
        have hb := norm_gGram_le a b
        have hnn := gSig_nonneg a
        have hg := abs_nonneg g
        rw [hmin]
        nlinarith
      · have hz : gGram a b = 0 := by simp only [gGram, if_neg h]
        have h1 : (1 : ℝ) ≤ min (gSig a) (gSig b) := le_min (one_le_gSig a) (one_le_gSig b)
        have hg := abs_nonneg g
        rw [hz, norm_zero]
        nlinarith)
    (fun a b => le_trans (norm_gCoupling_le g a b) (by norm_num))
    (fun a b hb => by
      have h : b.1 = a.1 := mem_gNbr.mp hb
      have hcs : gSig a = gSig b := by simp only [gSig, h]
      have hg := abs_nonneg g
      rw [hcs, sub_self, abs_zero]
      linarith)

@[simp] theorem qgFullModes_sig (g : ℝ) : (qgFullModes g).sig = gSig := rfl

@[simp] theorem qgFullModes_A (g : ℝ) : (qgFullModes g).A = gGram := rfl

@[simp] theorem qgFullModes_B (g : ℝ) : (qgFullModes g).B = gCoupling g := rfl

@[simp] theorem qgFullModes_nbr (g : ℝ) : (qgFullModes g).nbr = gNbr := rfl

/-! ## 6. Essential self-adjointness, by Faris–Lavine -/

/-- The complete gauge-fixed QG one-particle Hamiltonian, as an operator into the bundled
space. -/
def qgFullOp (W : WallPot) (g : ℝ) : secCore (ι := GMode) →ₗ[ℂ] qgSecSpace.carrier :=
  secHam W (qgFullModes g)

theorem qgFullOp_symmetricOn (W : WallPot) (g : ℝ) :
    SymmetricOn (secCore (ι := GMode)) (qgFullOp W g) :=
  secHam_symmetricOn W _

/-- **The same on the finite-particle core**, where the Hamiltonian is originally defined:
Faris–Lavine on the core itself, through
`BookProof.QgOuterFockCoreFL.CoreData.esa_on_core`. -/
theorem qgFull_esa_core_fl (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (secCore (ι := GMode)) (secHam W (qgFullModes g)) := by
  refine (secData W (qgFullModes g)).esa_on_core (secHam_symmetricOn W _)
    (c := 6 * (qgFullModes g).K) (by have := (qgFullModes g).K_nonneg; linarith) ?_
  intro p
  have hc : commForm (secData W (qgFullModes g)).H₀ (secData W (qgFullModes g)).coreN p
      = commForm (secHam W (qgFullModes g)) (secDiag W (qgFullModes g)) p :=
    commForm_congr _ _ _ _ _ _ rfl (secData_coreN W (qgFullModes g) p)
  have hq : quadForm (secData W (qgFullModes g)).coreN p
      = quadForm (secDiag W (qgFullModes g)) p :=
    quadForm_congr _ _ _ _ rfl (secData_coreN W (qgFullModes g) p)
  rw [hc, hq]
  exact secHam_commForm_le W (qgFullModes g) p

theorem qgFullOp_esa (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (secCore (ι := GMode)) (qgFullOp W g) :=
  qgFull_esa_core_fl W g

/-! ## 7. The enclosures of the complete Hamiltonian -/

/-- The finite-particle core is dense in the outer Fock space. -/
theorem secCore_dense :
    Dense ((secCore (ι := GMode) : Submodule ℂ (Sec GMode)) : Set (Sec GMode)) :=
  dsCore_dense fun _ => ccDomain_dense

set_option maxHeartbeats 1000000 in

/-- **The `n`-particle derivation of the complete QG Hamiltonian on the symmetric tensor
power is essentially self-adjoint on the symmetrized core** `bosonicProj (secCore^{⊗n})`. -/
theorem qgFull_bosonic_core_esa (W : WallPot) (g : ℝ) (n : ℕ) :
    EssentiallySelfAdjointOn
      (redDom (bosonicProj qgSecSpace n)
        (sectorCore qgSecSpace (secCore (ι := GMode)) (secCore (ι := GMode)) n))
      (bosonicCoreOp qgSecSpace (secCore (ι := GMode)) (qgFullOp W g)
        (secCore (ι := GMode)) n) :=
  @essentiallySelfAdjointOn_bosonic_core_of_esa qgSecSpace _
    (secCore (ι := GMode)) (qgFullOp W g) secCore_dense
    (qgFullOp_symmetricOn W g) (qgFullOp_esa W g) qgSecSpace
    (secCore (ι := GMode)) (qgFullOp W g) (secCore (ι := GMode))
    (IsGraphCore.refl (qgFullOp W g)) n

set_option maxHeartbeats 1000000 in

/-- **`dΓ` of the complete QG Hamiltonian is essentially self-adjoint on the bosonic Fock
space** over `secCore` (algebraic direct sum of the symmetric sectors). -/
theorem qgFull_bosonicFock_esa (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (bosonicFockDom qgSecSpace (secCore (ι := GMode)))
      (bosonicFockOp qgSecSpace (secCore (ι := GMode)) (qgFullOp W g)) :=
  @bosonicFock_esa qgSecSpace _ (secCore (ι := GMode)) (qgFullOp W g)
    secCore_dense (qgFullOp_symmetricOn W g) (qgFullOp_esa W g)
    qgSecSpace (secCore (ι := GMode)) (qgFullOp W g)

/-- **The same on the bosonic Fock space as a Hilbert space** (Hilbert direct sum of the
completed symmetric sectors). -/
theorem qgFull_hbosonicFock_esa (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (hbosonicFockDom qgSecSpace (secCore (ι := GMode)))
      (hbosonicFockOp qgSecSpace (secCore (ι := GMode)) (qgFullOp W g)) :=
  hbosonicFock_esa (Hs := qgSecSpace) (qgFullOp W g) secCore_dense
    (qgFullOp_symmetricOn W g) (qgFullOp_esa W g)

/-- **The enclosure `dΓ(h)` of the complete QG Hamiltonian** (creation left / annihilation
right, general second quantization) is essentially self-adjoint on the finite-particle domain
over `secCore`. -/
theorem qgFull_dGamma_esa (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore qgSecSpace (secCore (ι := GMode))
        (secCore (ι := GMode)) n))
      (dGammaCoreOp qgSecSpace (secCore (ι := GMode)) (qgFullOp W g)
        (secCore (ι := GMode))) :=
  EsaOneParticle.dGamma_essentiallySelfAdjointOn_of_esa (Hs := qgSecSpace) (qgFullOp W g)
    secCore_dense (qgFullOp_symmetricOn W g) (qgFullOp_esa W g)













end

end BookProof.QgSymmetricSector
