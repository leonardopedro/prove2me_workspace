-- Generated from ChapterBddBelowFiberSumEsa.lean — solution of BookProof.BddBelowFiberSumEsa.fiberCore_dense
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
open BookProof.BddBelowFiberSumEsa












open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.BddBelowWallEsa BookProof.WallEsaSemibounded BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution :
    Dense ((fiberCore ι : Submodule ℂ (fiberSpace ι)) : Set (fiberSpace ι)) := dsCore_dense (fun _ => ccDomain_dense)
