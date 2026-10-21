-- Generated from ChapterFreeFieldBornFiberSpectrum.lean — solution of BookProof.ChapterFreeFieldBornFiberSpectrum.posSupport_unifDist_card
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberSpectrum
open BookProof.ChapterFreeFieldBornFiberSpectrum



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberTwo
open BookProof.ChapterFreeFieldBornFiberBounds


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {k : ℕ} (hk : 1 ≤ k) (hkn : k ≤ n) :
    (posSupport (unifDist n k)).card = k := by

  convert Finset.card_eq_sum_ones ( Finset.Iio k ) using 1;
  · refine Finset.card_bij ( fun x hx => x.1 ) ?_ ?_ ?_ <;> simp only [posSupport,
      Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_Iio, exists_prop];
    · unfold unifDist; aesop;
    · exact fun a₁ ha₁ a₂ ha₂ h => Fin.ext h;
    · intro b hb; use ⟨ b, by linarith ⟩ ; simp [ unifDist, hb ] ;
      linarith;
  · norm_num
