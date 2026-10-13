-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.inSector_sum
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_inSector_add
import Theorems.Thm_BookProof_FockSchur_inSector_zero_op
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} {κ : Type*} (S : Finset κ) (f : κ → FockAlg)
    (hf : ∀ k ∈ S, InSector n (f k)) : InSector n (∑ k ∈ S, f k) := by

  classical
  induction S using Finset.induction with
  | empty => simpa using inSector_zero_op n
  | insert a S ha ih =>
      rw [Finset.sum_insert ha]
      exact inSector_add (hf a (Finset.mem_insert_self a S))
        (ih fun k hk => hf k (Finset.mem_insert_of_mem hk))
