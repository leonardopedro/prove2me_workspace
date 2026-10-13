-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.diagUnboundedData_hamiltonian
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagFullData_hamiltonian
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.NavierStokesFlow.DiagonalEsa
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow.LpNat

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable (d : NSFullData F)

set_option maxHeartbeats 1000000 in

theorem solution :
    diagUnboundedData.hamiltonian = diagOp (fun n => -(2 * (n : ℝ))) := by
  unfold diagUnboundedData
  rw [diagFullData_hamiltonian]
  congr 1
  funext n
  simp only [diagFullSymbol, Fin.sum_univ_three]
  norm_num [nsVelIdx, nsGradIdx, nsLapIdx, Fin.ext_iff]
