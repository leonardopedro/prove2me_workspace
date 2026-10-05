-- Generated from ChapterFreeFieldBornFiberTwo.lean — solution of BookProof.ChapterFreeFieldBornFiberTwo.posSupport_nonempty
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberTwo
open BookProof.ChapterFreeFieldBornFiberTwo



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p : Fin n → ℝ} (hp : p ∈ stdSimplex ℝ (Fin n)) :
    (posSupport p).Nonempty := by

  by_contra h_empty;
  simp_all only [posSupport, Finset.not_nonempty_iff_eq_empty, Finset.ext_iff, Finset.mem_filter,
      Finset.mem_univ, true_and, Finset.notMem_empty, iff_false, not_lt];
  exact absurd ( hp.2 ▸ Finset.sum_nonpos fun i _ => h_empty i ) ( by norm_num )
