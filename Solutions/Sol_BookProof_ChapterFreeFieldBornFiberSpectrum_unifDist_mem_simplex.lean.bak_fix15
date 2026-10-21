-- Generated from ChapterFreeFieldBornFiberSpectrum.lean — solution of BookProof.ChapterFreeFieldBornFiberSpectrum.unifDist_mem_simplex
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
    unifDist n k ∈ stdSimplex ℝ (Fin n) := by

  constructor;
  · exact fun x => by unfold unifDist; split_ifs <;> positivity;
  · unfold unifDist;
    norm_num [ Finset.sum_ite ];
    rw [ show ( Finset.univ.filter fun x : Fin n => ( x : ℕ ) < k ).card = k from ?_,
        mul_inv_cancel₀ ( by positivity ) ];
    rw [ Finset.card_eq_of_bijective ];
    focus (use fun i hi => ⟨ i, by linarith ⟩);
    · grind;
    · grind;
    · lia
