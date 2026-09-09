import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent

open BookProof.ChapterNavierStokesThreeComponent




open Matrix
open scoped ComplexConjugate


variable {(i k : Fin 3) : Function.Injective (swapVel i k)}


theorem swapVel_injective := by sorry
