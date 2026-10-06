-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.ghostNumber_occ
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterNavierStokes
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.NavierStokes
open BookProof.SmCar
open BookProof.SmBrstGhost

variable {m : ℕ}



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

theorem BookProof.SmBrstGhost.ghostNumber_occ (m : ℕ) (S : Finset (Fin (m + 12))) :
    ghostNumber m (occ S)
      = (Finset.univ.filter (fun a : Fin 12 => ghostMode m a ∈ S)).card • occ S := by sorry
